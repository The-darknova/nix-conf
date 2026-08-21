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
    profiles."Default Profile" = {
      isDefault = true;
      path = "4uo8kd0b.Default Profile";
      sine.enable = true;
    };
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

  # Fix for virt-manager clipboard (copy from guest to host) failing on Wayland
  home.file.".local/share/applications/virt-manager.desktop".text = ''
    [Desktop Entry]
    Name=Virtual Machine Manager
    Icon=virt-manager
    Exec=env GDK_BACKEND=x11 virt-manager %U
    Terminal=false
    Type=Application
    Categories=System;Emulator;
  '';

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
    installMkcert = config.lib.dag.entryAfter ["writeBoundary"] ''
      export CAROOT="${config.home.homeDirectory}/.local/share/mkcert"
      if [ ! -f "$CAROOT/rootCA.pem" ]; then
        mkdir -p "$CAROOT"
        run ${pkgs.mkcert}/bin/mkcert -install || true
      fi
    '';

    installCaelestiaDots = config.lib.dag.entryAfter ["installMkcert"] ''
      # 1. Clone dotfiles if missing
      if [ ! -d "${config.home.homeDirectory}/.config/caelestia-dots" ]; then
        run ${pkgs.git}/bin/git clone https://github.com/caelestia-dots/caelestia "${config.home.homeDirectory}/.config/caelestia-dots" > /tmp/caelestia-git-clone.log 2>&1 || true
      fi

      # 2. Global Scheme Init
      if [ ! -f "${config.home.homeDirectory}/.local/state/caelestia/scheme.json" ] && command -v caelestia >/dev/null 2>&1; then
        run caelestia scheme set -n caelestia || true
      fi

      # 3. VSCode Extension
      if command -v code >/dev/null 2>&1; then
        run code --install-extension ${config.home.homeDirectory}/.config/caelestia-dots/vscode/caelestia-vscode-integration/caelestia-vscode-integration-*.vsix --force || true
      fi

      # 4. Spicetify Configuration
      if command -v spicetify >/dev/null 2>&1; then
        run spicetify config current_theme caelestia color_scheme caelestia custom_apps marketplace || true
        run spicetify apply || true
      fi

      # 5. XDG User Dirs
      run ${pkgs.xdg-user-dirs}/bin/xdg-user-dirs-update || true
    '';

    injectHyprlandExtras = config.lib.dag.entryAfter ["installCaelestiaDots"] ''
      HYPR_DIR="${config.home.homeDirectory}/.config/caelestia-dots/hypr/hyprland"
      if [ -d "$HYPR_DIR" ]; then
        # Create external-brightness.lua
        cat << 'EOF' > "$HYPR_DIR/external-brightness.lua"
hl.bind("SHIFT + XF86MonBrightnessUp", hl.dsp.exec_cmd("external-brightness up"), { locked = true, repeating = true })
hl.bind("SHIFT + XF86MonBrightnessDown", hl.dsp.exec_cmd("external-brightness down"), { locked = true, repeating = true })
EOF

        # Inject require into keybinds.lua if it doesn't exist
        if ! grep -q "require(\"hyprland.external-brightness\")" "$HYPR_DIR/keybinds.lua"; then
          echo 'require("hyprland.external-brightness")' >> "$HYPR_DIR/keybinds.lua"
        fi

        # Create external-autostart.lua for nm-applet
        cat << 'EOF' > "$HYPR_DIR/external-autostart.lua"
hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user start hyprland-session.target || systemctl --user start graphical-session.target")
    hl.exec_cmd("nm-applet --indicator")
end)
EOF

        # Inject require into execs.lua if it doesn't exist
        if ! grep -q "require(\"hyprland.external-autostart\")" "$HYPR_DIR/execs.lua"; then
          echo 'require("hyprland.external-autostart")' >> "$HYPR_DIR/execs.lua"
        fi

        # Create external-input.lua for keyboard layouts
        cat << 'EOF' > "$HYPR_DIR/external-input.lua"
hl.config({
    input = {
        kb_layout = "us,fr",
        kb_options = "grp:win_space_toggle",
    }
})
EOF

        # Inject require into input.lua if it doesn't exist
        if ! grep -q "require(\"hyprland.external-input\")" "$HYPR_DIR/input.lua"; then
          echo 'require("hyprland.external-input")' >> "$HYPR_DIR/input.lua"
        fi
      fi
    '';
  };

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  home.stateVersion = "26.05";
}
