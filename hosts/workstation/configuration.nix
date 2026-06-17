{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./containers.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "darknova";
  # Use NetworkManager instead of wpa_supplicant for Wi-Fi and VPNs
  networking.networkmanager.enable = true;
  networking.networkmanager.plugins = with pkgs; [ networkmanager-openconnect ];

  # VPNs
  services.tailscale.enable = true;
  
  time.timeZone = "Africa/Lome"; # Update based on your actual timezone

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Desktop Environments
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.theme = "sddm-astronaut-theme";

  # Enable Gnome Keyring for secret management (wifi passwords, etc)
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  # Enable Hyprland
  programs.hyprland.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.variant = "";

  # Enable CUPS support
  services.printing.enable = true;
  # Enable Bluetooth support
  hardware.bluetooth.enable = true;
  
  # Enable sound support with pipewire
  services.pulseaudio.enable = false; # Disable PulseAudio if previously enabled
  security.rtkit.enable = true; # Real-time scheduling for audio
  services.pipewire = {
    enable = true;
    alsa.enable = true; # ALSA support for PipeWire
    alsa.support32Bit = true; # 32-bit support for ALSA
    jack.enable = true; # JACK support for low-latency audio
  };

  # Virtualization & Containerization
  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  programs.virt-manager.enable = true;
  
  # Incus Configuration
  virtualisation.incus = {
    enable = true;
    ui.enable = true;
    preseed = {
      config = {
        "core.https_address" = ":10443";
      };
      networks = [
        {
          name = "incusbr0";
          type = "bridge";
          config = {
            "ipv4.address" = "11.0.200.1/24";
            "ipv6.address" = "none";
          };
        }
      ];
      profiles = [
        {
          name = "default";
          devices = {
            eth0 = {
              name = "eth0";
              network = "incusbr0";
              type = "nic";
            };
            root = {
              path = "/";
              pool = "default";
              size = "35GiB";
              type = "disk";
            };
          };
        }
      ];
      storage_pools = [
        {
          name = "default";
          driver = "btrfs";
          config = {
            source = "/var/lib/incus/storage-pools/default";
          };
        }
      ];
    };
  };

  # Define a user account
  users.users.danny = {
    isNormalUser = true;
    description = "Daniel ADJIWANOU";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" "qemu" "wireshark" "incus-admin" "adbusers" ]; # Add user to necessary groups
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable Steam for gaming
  programs.steam.enable = true;

  # Base system packages
  environment.systemPackages = with pkgs; [
    (pkgs.sddm-astronaut.override {
      embeddedTheme = "hyprland_kath";
    })
    android-tools
    wget
    curl
    git
    vim
    nano
  ];

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Automatic Garbage Collection & Nix Settings
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
  nix.settings.auto-optimise-store = true;

  # Hardening: Firewall Configuration
  networking.nftables.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ ]; # Strict default for laptops
    allowedUDPPorts = [ ];
    # Trust container/VM networks so internal routing isn't blocked
    trustedInterfaces = [ "docker-net-br0" "incusbr0" "virbr0" ];
  };

  system.stateVersion = "26.05";
}
