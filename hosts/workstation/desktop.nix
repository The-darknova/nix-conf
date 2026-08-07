{ config, pkgs, ... }:

{
  # ---------------------------------------------------------------------------
  # Display & Desktop Environments
  # ---------------------------------------------------------------------------

  # X server is required even in Wayland-only setups (SDDM depends on libX11).
  services.xserver.enable = true;

  # KDE Plasma 6 as the primary desktop environment.
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    kde-gtk-config
  ];

  # SDDM display manager with Wayland backend.
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

  # ---------------------------------------------------------------------------
  # Wayland / XDG Portals
  # ---------------------------------------------------------------------------

  # Enable Hyprland as an alternative compositor.
  programs.hyprland.enable = true;

  # XDG desktop portal configuration.
  # Each session type has its own explicit default to avoid launching multiple
  # portal backends simultaneously (a known crash cause on Hyprland).
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      kdePackages.xdg-desktop-portal-kde
      xdg-desktop-portal-gtk
    ];
    config = {
      # Default for all other sessions (KDE Plasma): use the KDE portal.
      common.default = [ "kde" ];
      # Hyprland sessions: use the Hyprland portal exclusively.
      # xdg-desktop-portal-hyprland is added automatically by programs.hyprland.
      hyprland = {
        default = [ "hyprland" ];
        # Delegate file pickers to KDE portal for a better native look.
        "org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
      };
    };
  };

  systemd.user.targets.hyprland-session = {
    unitConfig = {
      Description = "Hyprland compositor session";
      BindsTo = "graphical-session.target";
      Wants = "graphical-session-pre.target";
      After = "graphical-session-pre.target";
    };
  };

  # ---------------------------------------------------------------------------
  # Keyring & Authentication
  # ---------------------------------------------------------------------------

  # GNOME Keyring for storing WiFi passwords, SSH keys, etc.
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  # dconf is required for GTK themes and portal settings to apply correctly.
  programs.dconf.enable = true;

  # Fix Dolphin / KDE apps crash by setting XDG_MENU_PREFIX globally.
  environment.variables.XDG_MENU_PREFIX = "plasma-";

  # ---------------------------------------------------------------------------
  # Keyboard
  # ---------------------------------------------------------------------------

  services.xserver.xkb.layout = "us,fr";
  services.xserver.xkb.variant = "";
  services.xserver.xkb.options = "grp:win_space_toggle";

  # ---------------------------------------------------------------------------
  # Audio — PipeWire
  # ---------------------------------------------------------------------------

  # Disable PulseAudio; PipeWire provides its own PA-compatible socket.
  services.pulseaudio.enable = false;

  # Real-time scheduling priority for audio threads.
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;        # ALSA compatibility layer
    alsa.support32Bit = true;  # Required for 32-bit apps (Wine, Steam)
    jack.enable = true;        # JACK compatibility for low-latency audio
    pulse.enable = true;       # PulseAudio compatibility socket — required by
                               # most apps (Spotify, Vesktop, browsers, games)
  };

  # ---------------------------------------------------------------------------
  # Bluetooth
  # ---------------------------------------------------------------------------

  hardware.bluetooth.enable = true;
  # Ensure the Bluetooth adapter is powered on automatically after boot or
  # wake from sleep.
  hardware.bluetooth.powerOnBoot = true;

  # Fix for Xbox Wireless Controller BLE connect/disconnect loop (HOG unlikely error)
  hardware.bluetooth.settings = {
    General = {
      Privacy = "device";
      JustWorksRepairing = "always";
      FastConnectable = "true";
    };
  };

  # Enable Xbox Wireless Controller support (fixes Bluetooth connect loop)
  hardware.xpadneo.enable = true;

  # ---------------------------------------------------------------------------
  # Printing
  # ---------------------------------------------------------------------------

  services.printing = {
    enable = true;
    # Drivers for common printer brands:
    #   hplip        — HP printers (OfficeJet, LaserJet, DeskJet, etc.)
    #   gutenprint   — Canon, Ricoh, Epson, and hundreds of other models
    #   gutenprintBin — Binary-only Gutenprint drivers for some models
    drivers = with pkgs; [
      hplip
      gutenprint
      gutenprintBin
    ];
  };

  # Avahi (mDNS/DNS-SD) enables automatic discovery of network printers
  # without needing to manually enter IP addresses.
  services.avahi = {
    enable = true;
    nssmdns4 = true;   # Allow applications to resolve .local hostnames
    openFirewall = true;
  };
}
