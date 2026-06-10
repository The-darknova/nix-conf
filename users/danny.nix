{ config, pkgs, inputs, ... }:

{
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

    # System Administration Tools
    btop
    tmux
    jq
    yq-go
    bind      # provides dig, nslookup
    whois
    mtr
    lsof
    rsync
    unzip
    strace

    # Defensive Security / SOC Operations Tools
    nmap
    tcpdump
    socat
    wireshark
    binwalk
    volatility3
    sleuthkit
    yara
    cyberchef

    # Gaming & Browsers
    prismlauncher
    zen-browser
    firefox
    google-chrome
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

  # Declaratively link Caelestia Dots
  home.file.".local/share/caelestia".source = inputs.caelestia-dots;
  home.file.".config/caelestia".source = "${inputs.caelestia-dots}/caelestia";
  home.file.".config/hypr".source = "${inputs.caelestia-dots}/hypr";
  home.file.".config/foot".source = "${inputs.caelestia-dots}/foot";

  # Prism Launcher offline accounts configuration
  home.file.".local/share/PrismLauncher/accounts.json".text = ''
    { "accounts": [ { "entitlement": { "canPlayMinecraft": true, "ownsMinecraft": true }, "msa-client-id": "", "type": "MSA" }, { "active": true, "profile": { "capes": [ ], "id": "0c79d88a112537a0a302f01afa6bc94a", "name": "YOUR-NICKNAME", "skin": { "id": "", "url": "", "variant": "" } }, "type": "Offline", "ygg": { "extra": { "clientToken": "8be89b1112474b5fb8f061699ff41bda", "userName": "YOUR-NICKNAME" }, "iat": 1738858981, "token": "0" } } ], "formatVersion": 3 }
  '';

  # Zsh configuration
  programs.zsh = {
    enable = true;
    
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
    };

    initExtra = ''
      # Source Jovial theme directly from the Nix store via the Flake input
      source ${inputs.jovial}/jovial.plugin.zsh

      # Add any custom aliases or environment variables here
      alias ll="ls -l"
      
      # SOC and Sysadmin quick aliases
      alias ports="sudo lsof -i -P -n | grep LISTEN"
      alias myip="curl -s ifconfig.me"
      alias pcap-capture="sudo tcpdump -i any -w capture.pcap"
    '';
  };

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that introduces backwards
  # incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05";
}
