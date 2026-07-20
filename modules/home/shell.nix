{ config, lib, pkgs, ... }:

let
  jovialTheme = pkgs.fetchFromGitHub {
    owner = "zthxxx";
    repo = "jovial";
    rev = "426fe1fb612e85817ec23440a64f2732b8d34b3f";
    hash = "sha256-VvF1alXCLatkSDJGImxFkijiVwtOGYgH1gXlqLfgWcs=";
  };
in
{
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
      theme = "";
      plugins = [
        "git" "urltools" "bgnotify" "aliases" "ansible" "colorize"
        "docker" "docker-compose" "golang" "grc" "helm" "kubectl"
        "minikube" "pip" "podman" "ssh" "sudo" "vagrant" "copyfile"
        "argocd" "opentofu" "terraform"
      ];
    };

    plugins = [
      {
        name = "zsh-autocomplete";
        src = pkgs.fetchFromGitHub {
          owner = "marlonrichert";
          repo = "zsh-autocomplete";
          rev = "20f6c34f20270084b21211428afb6d2534aae8e9";
          hash = "sha256-M8gWOg/9ohkG2NiLVSGERINcmHJCfoES5IG2GBllrRo=";
        };
      }
      {
        name = "jovial";
        src = jovialTheme;
        file = "jovial.plugin.zsh";
      }
    ];

    initContent = lib.mkMerge [
      (lib.mkBefore ''
        # Save original TERM to avoid Zsh autocomplete crashes on missing terminfo keys (like TERM=dumb)
        _original_TERM="$TERM"
        if [[ "$TERM" == "dumb" || -z "$TERM" ]]; then
          export TERM="xterm-256color"
        fi
      '')
      ''
        # Source Jovial theme
        source ${jovialTheme}/jovial.zsh-theme

        # Add any custom aliases or environment variables here
        alias ll="ls -l"
        alias cat="bat"
        alias ls="eza"
        
        # SOC and Sysadmin quick aliases
        alias ports="sudo lsof -i -P -n | grep LISTEN"
        alias myip="curl -s ifconfig.me"
        alias pcap-capture="sudo tcpdump -i any -w capture.pcap"
        alias pcap-analyze="termshark -r"

        # NVM setup
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

        # Bind keys
        bindkey  "^[[H"   beginning-of-line
        bindkey  "^[[F"   end-of-line
        bindkey  "^[[3~"  delete-char

        # Local bin path
        export PATH="${config.home.homeDirectory}/.local/bin:$PATH"

        # Export NIX_LD_LIBRARY_PATH to LD_LIBRARY_PATH to fix Python pre-compiled wheels (e.g. numpy, pandas) in venvs
        if [ -n "$NIX_LD_LIBRARY_PATH" ]; then
          export LD_LIBRARY_PATH="$NIX_LD_LIBRARY_PATH:$LD_LIBRARY_PATH"
        fi

        # Restore TERM if it was overridden
        if [[ -n "$_original_TERM" ]]; then
          export TERM="$_original_TERM"
          unset _original_TERM
        fi
      ''
    ];
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

  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  # Enable wlogout
  programs.wlogout.enable = true;

  # Caelestia Shell configuration
  programs.caelestia = {
    enable = true;
    systemd = {
      enable = false;
      target = "graphical-session.target";
      environment = [];
    };

    cli = {
      enable = true;
      settings = {
        theme.enableGtk = false;
      };
    };
  };
}
