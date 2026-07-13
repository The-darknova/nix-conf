{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    ./virtualization.nix
    ./desktop.nix
    ./containers.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-8975b560-92f4-4180-b5cd-d1e03ad2b58b".device = "/dev/disk/by-uuid/8975b560-92f4-4180-b5cd-d1e03ad2b58b";

  # Fix AMD/Wayland suspend and wake crashes
  boot.kernelParams = [ "mem_sleep_default=deep" "amdgpu.sg_display=0" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  time.timeZone = "Africa/Lome"; # Update based on your actual timezone

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable zsh globally
  programs.zsh.enable = true;

  # Define a user account
  users.users.danny = {
    isNormalUser = true;
    description = "Daniel ADJIWANOU";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" "qemu" "wireshark" "incus-admin" "adbusers" "i2c" "video" ]; # Add user to necessary groups
  };

  # Hardware configuration
  hardware.i2c.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Trust mkcert local CA if generated
  security.pki.certificateFiles = if (builtins.pathExists "/home/danny/.local/share/mkcert/rootCA.pem") then [ "/home/danny/.local/share/mkcert/rootCA.pem" ] else [];

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
    zsh
    zsh-completions
    zsh-powerlevel10k
    zsh-syntax-highlighting
    nwg-displays
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

  system.stateVersion = "26.05";
}
