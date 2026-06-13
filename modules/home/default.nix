{ config, pkgs, ... }:

{
  imports = [
    ./plasma-config.nix
  ];

  home.username = "danny";
  home.homeDirectory = "/home/danny";

  # Allow unfree packages for home-manager as well
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # --- Sysadmin Toolkit ---
    # Networking
    mtr
    iperf3
    dnsutils # provides dig, nslookup
    ldns
    nmap
    netcat
    socat
    ipcalc
    openconnect
    openvpn
    tailscale # CLI tool

    # Process/Resource Monitoring
    htop
    btop
    glances
    sysstat
    lsof

    # File Management & Search
    ripgrep
    fd
    eza
    fzf
    jq
    yq-go
    tree
    bat

    # Terminal & Multiplexing
    tmux
    screen
    lolcat

    # Development & AI
    vscode
    kdePackages.kate
    kubectl
    ollama
    lmstudio

    # Graphics & Misc
    inkscape

    # Remote Management
    openssh
    sshfs
    ansible

    # --- SOC Analyst & Security Toolkit ---
    # Packet Analysis
    wireshark
    tshark
    tcpdump
    ngrep

    # Log Analysis & SIEM
    awscli2
    gojq

    # Forensics & Malware Analysis
    binutils # strings, objdump
    strace
    ltrace
    yara
    volatility3
    sleuthkit

    # Reconnaissance
    whois
    amass
    subfinder

    # Cryptography/Hashes
    hashdeep
    gnupg
  ];

  # Shell aliases
  home.shellAliases = {
    cat = "bat";
    ls = "eza";
    ll = "eza -l";
  };

  # Program configurations (dotfiles)
  programs.git = {
    enable = true;
    userName = "The-darknova";
    userEmail = "dannybloodfallen@gmail.com"; # Change this to your email
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      cat = "bat";
      ls = "eza";
      ll = "eza -l";
    };
  };

  programs.bat.enable = true;

  # Neovim, Tmux, etc., can be added here
  # programs.neovim.enable = true;
  # programs.tmux.enable = true;

  # KDE Custom Assets
  home.file.".local/share/plasma".source = ../../dotfiles/kde/plasma;
  home.file.".local/share/icons".source = ../../dotfiles/kde/icons;
  home.file.".local/share/aurorae".source = ../../dotfiles/kde/aurorae;

  home.stateVersion = "24.05";
}
