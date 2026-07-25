{ pkgs, ... }:

let
  escrcpy = pkgs.appimageTools.wrapType2 {
    pname = "escrcpy";
    version = "2.11.1";
    src = pkgs.fetchurl {
      url = "https://github.com/viarotel-org/escrcpy/releases/download/v2.11.1/Escrcpy-2.11.1-linux-x86_64.AppImage";
      sha256 = "1xz0fkggmp1n4aypxxqps33xsd59m6g9glxmcg39klc6vng8ipr4";
    };
  };

  externalBrightnessScript = pkgs.writeShellScriptBin "external-brightness" ''
    #!/bin/sh
    # This script controls external monitor brightness asynchronously to prevent blocking the compositor
    # Uses flock to drop concurrent requests, preventing I2C bus locks during key repeats.

    if [ "$1" = "up" ]; then
      ( flock -n 9 || exit 0; ${pkgs.ddcutil}/bin/ddcutil setvcp 10 + 5 ) 9>/tmp/external-brightness.lock & disown
    elif [ "$1" = "down" ]; then
      ( flock -n 9 || exit 0; ${pkgs.ddcutil}/bin/ddcutil setvcp 10 - 5 ) 9>/tmp/external-brightness.lock & disown
    else
      echo "Usage: external-brightness [up|down]"
      exit 1
    fi
  '';

  notion-webapp = pkgs.makeDesktopItem {
    name = "notion";
    desktopName = "Notion";
    exec = "${pkgs.chromium}/bin/chromium --app=https://www.notion.so --enable-features=UseOzonePlatform --ozone-platform=wayland";
    icon = "notion-app";
    type = "Application";
    categories = [ "Office" ];
    terminal = false;
  };
in
{
  home.packages = with pkgs; [
    externalBrightnessScript
    scrcpy
    escrcpy
    
    openconnect
    networkmanagerapplet

    # System Administration Toolkit
    btop
    htop
    glances
    sysstat
    zellij
    termshark
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
    micro

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
    telegram-desktop
    signal-desktop

    # Antigravity Development
    antigravity
    antigravity-cli

    # Programming Languages & Toolchains
    python3
    nodejs
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
    remmina

    # Office & Productivity
    onlyoffice-desktopeditors
    obsidian
    keepassxc
    zathura
    thunderbird

    # Edit, Graphics & Design Tools
    inkscape
    gimp
    krita
    imagemagick
    blender
    synfigstudio
    davinci-resolve

    # Miscellaneous Utilities
    vlc
    mpv
    winboat
    spotify
    yt-dlp
    diffutils
    thunar
    gh
    libsecret
    ddcutil
    notion-webapp
    chromium
    mkcert

    # DevOps
    kubectl
    kubernetes-helm
    k9s
    minikube
    argocd
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

    # Screen Recording & Screenshots
    gpu-screen-recorder
    grim
    slurp
    swappy

    # Other
    ani-cli
  ];
}
