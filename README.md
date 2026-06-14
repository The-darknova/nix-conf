# NixOS Flake & Home Manager Configuration

This repository contains my declarative NixOS configuration, managed using Nix Flakes and Home Manager. It is tailored for a Sysadmin / SOC Analyst workflow with a dual KDE Plasma / Hyprland desktop environment.

## 🚀 Features

- **Window Managers & DEs:** Hyprland (primary), KDE Plasma 6, and Caelestia Shell.
- **Sysadmin & Networking Toolkit:** `nmap`, `iperf3`, `ipcalc`, `dnsutils`, etc.
- **Security & SOC Toolkit:** `wireshark`, `tcpdump`, `yara`, `volatility3`, `sleuthkit`, etc.
- **Virtualization & Containerization:** Docker, QEMU/KVM (`virt-manager`), and VMware.
- **Development & AI:** VSCode, Kate, Kubectl, Ollama, and LM Studio.
- **Browsers:** Zen Browser (configured via Home Manager).
- **VPNs:** Tailscale (system-wide), OpenVPN, and OpenConnect.
- **Declarative Dotfiles:** KDE Plasma is managed declaratively using `plasma-manager`. Caelestia dots are symlinked cleanly using `xdg.configFile`.

## 📂 Repository Structure

- `flake.nix`: The entry point for the NixOS system and Home Manager configuration. Includes inputs for `plasma-manager`, `zen-browser`, and `caelestia-shell`.
- `hosts/workstation/configuration.nix`: System-level packages and daemon configurations (Docker, VMs, networking).
- `hosts/workstation/hardware-configuration.nix`: Hardware-specific boot and filesystem configuration.
- `modules/home/default.nix`: User-level dotfiles, CLI tools, and aliases managed by Home Manager.
- `modules/home/plasma-config.nix`: Declarative KDE configuration mapping to KDE globals and kwin configs.

## 🛠️ Installation & Setup

1. **Boot into a NixOS Live USB.**
2. **Partition & Mount** your drives.
3. **Generate Hardware Config:**
   ```bash
   sudo nixos-generate-config --root /mnt
   ```
4. **Copy the hardware configuration** to this repo:
   ```bash
   cp /mnt/etc/nixos/hardware-configuration.nix ./hosts/workstation/hardware-configuration.nix
   ```
5. **Install NixOS:**
   ```bash
   sudo nixos-install --flake .#workstation
   ```

## 🔄 Updating

To apply changes to the system:
```bash
sudo nixos-rebuild switch --flake .#workstation
```
