{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.zen-browser.homeModules.beta
    inputs.caelestia-shell.homeManagerModules.default
    ./packages.nix
    ./shell.nix
    ./desktop.nix
  ];

  home.username = "danny";
  home.homeDirectory = "/home/danny";

  # Enable Zen Browser
  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
  };

  # Prism Launcher offline accounts configuration
  home.file.".local/share/PrismLauncher/accounts.json".text = ''
    { "accounts": [ { "entitlement": { "canPlayMinecraft": true, "ownsMinecraft": true }, "msa-client-id": "", "type": "MSA" }, { "active": true, "profile": { "capes": [ ], "id": "0c79d88a112537a0a302f01afa6bc94a", "name": "YOUR-NICKNAME", "skin": { "id": "", "url": "", "variant": "" } }, "type": "Offline", "ygg": { "extra": { "clientToken": "8be89b1112474b5fb8f061699ff41bda", "userName": "YOUR-NICKNAME" }, "iat": 1738858981, "token": "0" } } ], "formatVersion": 3 }
  '';

  home.activation = {
    cloneCaelestiaDots = config.lib.dag.entryAfter ["writeBoundary"] ''
      export PATH="${pkgs.git}/bin:$PATH"
      if [ ! -d "${config.home.homeDirectory}/.config/caelestia-dots" ]; then
        run ${pkgs.git}/bin/git clone https://github.com/caelestia-dots/caelestia.git "${config.home.homeDirectory}/.config/caelestia-dots"
      fi
    '';
    setupZenChrome = config.lib.dag.entryAfter ["cloneCaelestiaDots"] ''
      shopt -s nullglob
      for chrome_dir in "${config.home.homeDirectory}"/.zen/*/chrome; do
        if [ -d "$chrome_dir" ] && [ ! -L "$chrome_dir/userChrome.css" ]; then
          run ln -sf "${config.home.homeDirectory}/.config/caelestia-dots/zen/userChrome.css" "$chrome_dir/userChrome.css"
        fi
      done
    '';
  };

  xdg.configFile = {
    "hypr".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/caelestia-dots/hypr";
    "foot".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/caelestia-dots/foot";
    "fish".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/caelestia-dots/fish";
    "fastfetch".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/caelestia-dots/fastfetch";
    "btop".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/caelestia-dots/btop";
    "uwsm".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/caelestia-dots/uwsm";
    "starship.toml".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/caelestia-dots/starship.toml";
    "spicetify".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/caelestia-dots/spicetify";
    "micro".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/caelestia-dots/micro";
    "Code/User/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/caelestia-dots/vscode/settings.json";
    "Code/User/keybindings.json".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/caelestia-dots/vscode/keybindings.json";
    "code-flags.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/caelestia-dots/vscode/flags.conf";
  };

  home.file.".mozilla/native-messaging-hosts/caelestiafox.json".text = ''
    {
        "name": "caelestiafox",
        "description": "Native app for CaelestiaFox extension.",
        "path": "${config.home.homeDirectory}/.local/lib/caelestia/caelestiafox",
        "type": "stdio",
        "allowed_extensions": ["caelestiafox@caelestia.org"]
    }
  '';
  home.file.".local/lib/caelestia/caelestiafox".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/caelestia-dots/zen/native_app/app.fish";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  home.stateVersion = "26.05";
}
