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

  home.file = {
    ".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/caelestia-dots/hypr";
    ".config/foot".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/caelestia-dots/foot";
    ".config/fastfetch".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/caelestia-dots/fastfetch";
    ".config/btop".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/caelestia-dots/btop";
    ".config/starship.toml".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/caelestia-dots/starship.toml";
    ".config/uwsm".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/caelestia-dots/uwsm";
    ".config/Thunar".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/caelestia-dots/thunar";
    ".config/micro".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/caelestia-dots/micro";
    ".config/spicetify".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/caelestia-dots/spicetify";
    ".config/Code/User/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/caelestia-dots/vscode/settings.json";
    ".config/Code/User/keybindings.json".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/caelestia-dots/vscode/keybindings.json";
  };

  home.activation = {
    installCaelestiaDots = config.lib.dag.entryAfter ["writeBoundary"] ''
      if [ ! -d "${config.home.homeDirectory}/.config/caelestia-dots" ]; then
        run git clone https://github.com/caelestia-dots/caelestia "${config.home.homeDirectory}/.config/caelestia-dots"
      fi
    '';
  };

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  home.stateVersion = "26.05";
}
