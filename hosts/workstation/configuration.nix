{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./containers.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "darknova";
  networking.networkmanager.enable = true;

  # VPNs
  services.tailscale.enable = true;
  
  time.timeZone = "UTC"; # Update based on your actual timezone

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Desktop Environments
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable KDE Plasma 6
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Enable Hyprland
  programs.hyprland.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.variant = "";

  # Virtualization & Containerization
  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
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
