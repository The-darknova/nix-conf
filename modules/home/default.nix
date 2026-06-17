{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.zen-browser.homeModules.default
    inputs.caelestia-shell.homeManagerModules.default
  ];

  home.username = "danny";
  home.homeDirectory = "/home/danny";

  home.packages = with pkgs; [
    openconnect
    networkmanagerapplet
    polkit_gnome

    # System Administration Toolkit
    btop
    htop
    glances
    sysstat
    tmux
    screen
    lolcat
    jq
    yq-go
    bind      # provides dig, nslookup (dnsutils)
    ldns
    whois
    mtr
    lsof
    rsync
    unzip
    strace
    ltrace
    ripgrep
    fd
    eza
    fzf
    tree
    bat

    # Networking
    iperf3
    nmap
    netcat
    socat
    ipcalc
    openconnect
    openvpn
    tailscale # CLI tool

    # Defensive Security / SOC Operations Tools
    tcpdump
    ngrep
    wireshark
    volatility3
    sleuthkit
    yara
    cyberchef
    zeek
    appimage-run
    awscli2
    gojq
    binutils # strings, objdump
    amass
    subfinder
    hashdeep
    gnupg

    # Gaming & Browsers
    prismlauncher
    firefox
    google-chrome
    vesktop

    # Antigravity Development
    antigravity
    antigravity-cli

    # Programming Languages & Toolchains
    python3
    go
    cargo
    rustc
    php
    jdk
    gcc
    gnumake
    cmake

    # Development & AI
    vscode
    kdePackages.kate
    ollama
    lmstudio

    # Remote Management
    openssh
    sshfs
    ansible

    # Office & Productivity
    onlyoffice-desktopeditors
    obsidian
    keepassxc
    zathura
    thunderbird

    # Graphics & Design Tools
    inkscape
    gimp
    krita
    imagemagick

    # Miscellaneous Utilities
    winboat
    spotify
    yt-dlp
    diffutils
    gh
    gemini-cli
    kubectl
    kubernetes-helm
    k9s
    terraform
    opentofu
    docker-compose
    # QEMU / Virtualization Utilities
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    virtio-win
    virtiofsd
    libguestfs
    guestfs-tools
    # Extra System Tools
    gparted
    traceroute
    powershell
    # Caelestia shell/dots dependencies
    hyprpicker
    wl-clipboard
    cliphist
    inotify-tools
    wireplumber
    trash-cli
    foot
    fish
    fastfetch
    starship
    papirus-icon-theme
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "zen.desktop";
      "x-scheme-handler/http" = "zen.desktop";
      "x-scheme-handler/https" = "zen.desktop";
      "x-scheme-handler/about" = "zen.desktop";
      "x-scheme-handler/unknown" = "zen.desktop";
    };
  };

  home.sessionVariables = {
    BROWSER = "zen";
  };



  # Enable Zen Browser
  programs.zen-browser.enable = true;

  # Caelestia Shell configuration
  programs.caelestia = {
    enable = true;
    systemd = {
      enable = false;
      target = "graphical-session.target";
      environment = [];
    };
    settings = {
      bar.status = {
        showBattery = true;
      };
      paths.wallpaperDir = "~/Pictures/Wallpapers";
    };
    cli = {
      enable = true;
      settings = {
        theme.enableGtk = false;
      };
    };
  };

  # Prism Launcher offline accounts configuration
  home.file.".local/share/PrismLauncher/accounts.json".text = ''
    { "accounts": [ { "entitlement": { "canPlayMinecraft": true, "ownsMinecraft": true }, "msa-client-id": "", "type": "MSA" }, { "active": true, "profile": { "capes": [ ], "id": "0c79d88a112537a0a302f01afa6bc94a", "name": "YOUR-NICKNAME", "skin": { "id": "", "url": "", "variant": "" } }, "type": "Offline", "ygg": { "extra": { "clientToken": "8be89b1112474b5fb8f061699ff41bda", "userName": "YOUR-NICKNAME" }, "iat": 1738858981, "token": "0" } } ], "formatVersion": 3 }
  '';


  # Shell aliases
  home.shellAliases = {
    cat = "bat";
    ls = "eza";
    ll = "eza -l";
  };

  # Program configurations (dotfiles)
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "The-darknova";
        email = "dannybloodfallen@gmail.com";
      };
    };
  };

  # Zsh configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git" "urltools" "bgnotify" "aliases" "ansible" "colorize"
        "docker" "docker-compose" "golang" "grc" "helm" "kubectl"
        "minikube" "pip" "podman" "ssh" "sudo" "vagrant" "copyfile"
        "argocd" "opentofu" "terraform"
      ];
    };

    initContent = ''
      # Jovial theme was here but input is missing from flake.nix
      # Add any custom aliases or environment variables here
      alias ll="ls -l"
      alias cat="bat"
      alias ls="eza"
      
      # SOC and Sysadmin quick aliases
      alias ports="sudo lsof -i -P -n | grep LISTEN"
      alias myip="curl -s ifconfig.me"
      alias pcap-capture="sudo tcpdump -i any -w capture.pcap"

      # NVM setup
      export NVM_DIR="$HOME/.nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
      [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

      # Bind keys
      bindkey  "^[[H"   beginning-of-line
      bindkey  "^[[F"   end-of-line
      bindkey  "^[[3~"  delete-char

      # Local bin path
      export PATH="/home/danny/.local/bin:$PATH"
    '';
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.bat.enable = true;

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  services.network-manager-applet.enable = true;

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

  home.activation = {
    cloneCaelestiaDots = config.lib.dag.entryAfter ["writeBoundary"] ''
      if [ ! -d "$HOME/.config/caelestia-dots" ]; then
        $DRY_RUN_CMD ${pkgs.git}/bin/git clone https://github.com/caelestia-dots/caelestia.git "$HOME/.config/caelestia-dots"
      fi
    '';
    setupZenChrome = config.lib.dag.entryAfter ["cloneCaelestiaDots"] ''
      for chrome_dir in "$HOME"/.zen/*/chrome; do
        if [ -d "$chrome_dir" ] && [ ! -L "$chrome_dir/userChrome.css" ]; then
          $DRY_RUN_CMD ln -sf "$HOME/.config/caelestia-dots/zen/userChrome.css" "$chrome_dir/userChrome.css"
        fi
      done
    '';
  };

  xdg.configFile = {
    "hypr".source = config.lib.file.mkOutOfStoreSymlink "/home/danny/.config/caelestia-dots/hypr";
    "foot".source = config.lib.file.mkOutOfStoreSymlink "/home/danny/.config/caelestia-dots/foot";
    "fish".source = config.lib.file.mkOutOfStoreSymlink "/home/danny/.config/caelestia-dots/fish";
    "fastfetch".source = config.lib.file.mkOutOfStoreSymlink "/home/danny/.config/caelestia-dots/fastfetch";
    "btop".source = config.lib.file.mkOutOfStoreSymlink "/home/danny/.config/caelestia-dots/btop";
    "uwsm".source = config.lib.file.mkOutOfStoreSymlink "/home/danny/.config/caelestia-dots/uwsm";
    "starship.toml".source = config.lib.file.mkOutOfStoreSymlink "/home/danny/.config/caelestia-dots/starship.toml";
    "spicetify".source = config.lib.file.mkOutOfStoreSymlink "/home/danny/.config/caelestia-dots/spicetify";
    "micro".source = config.lib.file.mkOutOfStoreSymlink "/home/danny/.config/caelestia-dots/micro";
    "Code/User/settings.json".source = config.lib.file.mkOutOfStoreSymlink "/home/danny/.config/caelestia-dots/vscode/settings.json";
    "Code/User/keybindings.json".source = config.lib.file.mkOutOfStoreSymlink "/home/danny/.config/caelestia-dots/vscode/keybindings.json";
    "code-flags.conf".source = config.lib.file.mkOutOfStoreSymlink "/home/danny/.config/caelestia-dots/vscode/flags.conf";
  };

  home.file.".mozilla/native-messaging-hosts/caelestiafox.json".text = ''
    {
        "name": "caelestiafox",
        "description": "Native app for CaelestiaFox extension.",
        "path": "/home/danny/.local/lib/caelestia/caelestiafox",
        "type": "stdio",
        "allowed_extensions": ["caelestiafox@caelestia.org"]
    }
  '';
  home.file.".local/lib/caelestia/caelestiafox".source = config.lib.file.mkOutOfStoreSymlink "/home/danny/.config/caelestia-dots/zen/native_app/app.fish";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that introduces backwards
  # incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05";
}
