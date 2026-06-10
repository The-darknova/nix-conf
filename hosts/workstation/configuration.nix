{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "workstation";
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
  virtualisation.vmware.host.enable = true; # Requires allowUnfree

  # Define a user account
  users.users.danny = {
    isNormalUser = true;
    description = "Danny";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Base system packages
  environment.systemPackages = with pkgs; [
    wget
    curl
    git
    vim
  ];

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.05";
}
