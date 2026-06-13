{ config, pkgs, inputs, ... }:

{
  imports = [
    ./plasma-config.nix
    inputs.zen-browser.homeModules.default
    inputs.caelestia-shell.homeManagerModules.default
  ];

  home.username = "danny";
  home.homeDirectory = "/home/danny";

  home.packages = with pkgs; [
    # Core dependencies for Caelestia Dots
    quickshell
    foot
    starship
    hyprpicker
    wl-clipboard
    cliphist
    inotify-tools
    wireplumber
    trash-cli
    fish

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
    tshark
    ngrep
    wireshark
    binwalk
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

  # Caelestia dots configuration
  xdg.configFile = {
    "hypr".source = "${inputs.caelestia-dots}/hypr";
    "foot".source = "${inputs.caelestia-dots}/foot";
    "fish".source = "${inputs.caelestia-dots}/fish";
    "fastfetch".source = "${inputs.caelestia-dots}/fastfetch";
    "btop".source = "${inputs.caelestia-dots}/btop";
    "uwsm".source = "${inputs.caelestia-dots}/uwsm";
    "starship.toml".source = "${inputs.caelestia-dots}/starship.toml";
  };

  # Enable Caelestia shell
  programs.caelestia.enable = true;
  programs.caelestia.cli.enable = true;

  # Enable Zen Browser
  programs.zen-browser.enable = true;

  # Prism Launcher offline accounts configuration
  home.file.".local/share/PrismLauncher/accounts.json".text = ''
    { "accounts": [ { "entitlement": { "canPlayMinecraft": true, "ownsMinecraft": true }, "msa-client-id": "", "type": "MSA" }, { "active": true, "profile": { "capes": [ ], "id": "0c79d88a112537a0a302f01afa6bc94a", "name": "YOUR-NICKNAME", "skin": { "id": "", "url": "", "variant": "" } }, "type": "Offline", "ygg": { "extra": { "clientToken": "8be89b1112474b5fb8f061699ff41bda", "userName": "YOUR-NICKNAME" }, "iat": 1738858981, "token": "0" } } ], "formatVersion": 3 }
  '';

  # KDE Custom Assets
  home.file.".local/share/plasma".source = ../../dotfiles/kde/plasma;
  home.file.".local/share/icons".source = ../../dotfiles/kde/icons;
  home.file.".local/share/aurorae".source = ../../dotfiles/kde/aurorae;

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
