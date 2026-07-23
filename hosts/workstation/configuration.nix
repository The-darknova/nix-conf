{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./hardware.nix        # AMD-specific kernel params and module config
    ./sleep.nix           # Suspend/resume stability (PipeWire restart on wake)
    ./networking.nix
    ./virtualization.nix
    ./desktop.nix
    ./containers.nix
  ];

  # ---------------------------------------------------------------------------
  # Boot
  # ---------------------------------------------------------------------------

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # LUKS swap entry
  boot.initrd.luks.devices."luks-8975b560-92f4-4180-b5cd-d1e03ad2b58b".device = "/dev/disk/by-uuid/8975b560-92f4-4180-b5cd-d1e03ad2b58b";


  # Use the latest stable kernel for best hardware support and bug fixes.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # ---------------------------------------------------------------------------
  # Memory Management
  # ---------------------------------------------------------------------------

  # Zram swap: creates a compressed RAM-backed swap device using zstd.
  # This is dramatically faster than the encrypted disk swap for memory-pressure
  # situations (e.g. Zen Browser peaking at ~11GB, Electron apps, Docker).
  # With 32GB RAM and 50% allocation, you get ~16GB zram which compresses to
  # an effective ~32-48GB equivalent before hitting the slow disk swap.
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50; # 16GB zram from 32GB RAM
  };

  # Kernel memory management tuning optimized for zram:
  #   vm.swappiness = 100   — Eagerly compress anonymous memory into zram to
  #                           prevent dropping executable pages (which causes segfaults).
  #   vm.page-cluster = 0   — Disable read-ahead for swap (essential for zram).
  #   vm.vfs_cache_pressure = 50 — Retain more dentries/inodes in RAM.
  #   vm.dirty_ratio = 10   — Flush dirty pages to disk earlier (good for NVMe SSD).
  #   vm.dirty_background_ratio = 5 — Start background writeback earlier.
  boot.kernel.sysctl = {
    "vm.swappiness"             = 100;
    "vm.page-cluster"           = 0;
    "vm.vfs_cache_pressure"     = 50;
    "vm.dirty_ratio"            = 10;
    "vm.dirty_background_ratio" = 5;
  };

  # ---------------------------------------------------------------------------
  # Locale & Time
  # ---------------------------------------------------------------------------

  time.timeZone = "Africa/Lome";
  i18n.defaultLocale = "en_US.UTF-8";

  # ---------------------------------------------------------------------------
  # Shell
  # ---------------------------------------------------------------------------

  programs.zsh.enable = true;

  # ---------------------------------------------------------------------------
  # User Account
  # ---------------------------------------------------------------------------

  users.users.danny = {
    isNormalUser = true;
    description = "Daniel ADJIWANOU";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager" # Network configuration via nmcli / nm-applet
      "wheel"          # Sudo access
      "docker"         # Docker daemon socket access
      "libvirtd"       # Libvirt / virt-manager
      "kvm"            # KVM hardware virtualisation (replaces the incorrect "qemu" group)
      "wireshark"      # Packet capture without root (via dumpcap setcap)
      "incus-admin"    # Incus container management
      "adbusers"       # ADB USB device access
      "i2c"            # I2C bus access for external monitor brightness
      "video"          # Video device access (e.g. webcam, GPU tools)
    ];
  };

  # Enable the wireshark program module so dumpcap gets the required setcap
  # capability and the wireshark group is created with proper udev rules.
  programs.wireshark.enable = true;

  # ---------------------------------------------------------------------------
  # Hardware & Firmware
  # ---------------------------------------------------------------------------

  hardware.i2c.enable = true;

  # Load all redistributable firmware (WiFi, Bluetooth, GPU, NVMe, etc.).
  hardware.enableRedistributableFirmware = true;

  # Firmware update service (fwupd) — keeps NVMe, BT adapters, etc. up to date.
  services.fwupd.enable = true;

  # Disk / USB mount daemon used by Thunar, Dolphin, and other file managers.
  services.udisks2.enable = true;

  # GNOME Virtual File System (gvfs) provides the volume monitor backend for GTK.
  # Without this, GTK apps (browsers, editors) can segfault when udisks2 broadcasts
  # a new unencrypted or mounted volume over D-Bus.
  services.gvfs.enable = true;

  # ---------------------------------------------------------------------------
  # Security
  # ---------------------------------------------------------------------------

  # Trust mkcert local CA if it has been generated.
  security.pki.certificateFiles =
    if (builtins.pathExists "/home/danny/.local/share/mkcert/rootCA.pem")
    then [ "/home/danny/.local/share/mkcert/rootCA.pem" ]
    else [];

  # ---------------------------------------------------------------------------
  # Gaming
  # ---------------------------------------------------------------------------

  programs.steam.enable = true;

  # ---------------------------------------------------------------------------
  # Base System Packages
  # ---------------------------------------------------------------------------

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
    zsh
    zsh-completions
    zsh-powerlevel10k
    zsh-syntax-highlighting
    nwg-displays

    # Screen Recording & Screenshots (Global to ensure PATH in Hyprland)
    gpu-screen-recorder
    grim
    slurp
    swappy
  ];

  # ---------------------------------------------------------------------------
  # Nix Settings
  # ---------------------------------------------------------------------------

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Pin the system-wide nixpkgs registry and NIX_PATH to the flake's locked
  # nixpkgs. This ensures `nix run nixpkgs#foo` uses the same version as the
  # installed system, avoiding silent version mismatches.
  nix.registry.nixpkgs.flake = inputs.nixpkgs;
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  # Automatic garbage collection and store optimisation.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
  nix.settings.auto-optimise-store = true;

  # ---------------------------------------------------------------------------

  system.stateVersion = "26.05";
}
