{ config, pkgs, ... }:

{
  # Default theme config
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
  qt = {
    enable = true;
    platformTheme.name = "kde";
    style.name = "breeze";
  };
  
  # Standardizes XDG Desktop Portal settings for dark mode
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
    "org/gnome/desktop/privacy" = {
      remember-recent-files = false;
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "zen-beta.desktop";
      "x-scheme-handler/http" = "zen-beta.desktop";
      "x-scheme-handler/https" = "zen-beta.desktop";
      "x-scheme-handler/about" = "zen-beta.desktop";
      "x-scheme-handler/unknown" = "zen-beta.desktop";
    };
  };

  home.sessionVariables = {
    # Enable Wayland support in Firefox / Zen Browser
    MOZ_ENABLE_WAYLAND = "1";
    # Enable Wayland support in Electron / Chromium apps (VS Code, Obsidian, etc.)
    NIXOS_OZONE_WL = "1";
    # Qt / KDE Wayland compatibility
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    # Note: XDG_MENU_PREFIX is set at the system level in hosts/workstation/desktop.nix
  };

  xdg.configFile."swappy/config".text = ''
    [Default]
    save_dir=''${HOME}/Pictures/Screenshot
    save_filename_format=swappy-%Y%m%d-%H%M%S.png
    show_panel=false
    line_size=5
    text_size=20
    text_font=sans-serif
  '';

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  services.network-manager-applet.enable = true;

  # polkit authentication agent — needed by apps that require privilege escalation
  # (e.g. gparted, virt-manager, system settings). Kept here alongside the
  # package so the unit and its binary are always in sync.
  home.packages = [ pkgs.polkit_gnome ];

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    Unit = {
      Description = "polkit-gnome-authentication-agent-1";
      Wants = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
