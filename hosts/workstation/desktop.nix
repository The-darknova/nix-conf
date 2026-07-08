{ config, pkgs, ... }:

{
  # Desktop Environments
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";
    extraPackages = with pkgs.kdePackages; [
      qtsvg
      qtmultimedia
      qtvirtualkeyboard
    ];
  };

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
}
