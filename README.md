# NixOS Flake & Home Manager Configuration

Welcome to my declarative NixOS configuration repository. Managed via Nix Flakes and Home Manager, this setup is tailored for a **Sysadmin / SOC Analyst** workflow, prioritizing security tools, virtualization, and a clean, responsive desktop experience.

## 🚀 Key Features

- **Window Managers & DEs:** Hyprland (primary Wayland compositor) and KDE Plasma 6.
- **Sysadmin Toolkit:** Comprehensive networking tools (`nmap`, `iperf3`, `ipcalc`, `dnsutils`).
- **Security & SOC:** Dedicated forensics and packet analysis tools (`wireshark`, `tcpdump`, `yara`, `volatility3`, `sleuthkit`).
- **Virtualization & Containerization:** Full stack support with Docker, QEMU/KVM (`virt-manager`), and VMware.
- **Development & AI:** VSCode, Kate, Kubectl, Ollama, and LM Studio.
- **VPNs & Networking:** Tailscale for mesh networking, OpenVPN, and OpenConnect.
- **Declarative User Environment:** Home Manager handles dotfiles, CLI tools (Zsh, fzf, Starship), and GTK/Qt theming automatically.

## 📂 Configuration Overview

The repository is modularly structured, separating system-level configuration from user-level dotfiles.

### System Configuration (`hosts/workstation/`)
| File | Description |
|---|---|
| `configuration.nix` | Core system daemon configurations, global packages, and user definitions. |
| `desktop.nix` | System-wide display manager and desktop environments (Hyprland, KDE). |
| `hardware.nix` | Hardware-specific optimizations (GPU/CPU settings). |
| `hardware-configuration.nix` | Auto-generated filesystem, boot, and kernel module setup. |
| `networking.nix` | NetworkManager, Firewall, Tailscale, and VPN configurations. |
| `containers.nix` | Docker/OCI container definitions and networking. |
| `virtualization.nix` | QEMU/KVM, libvirtd, and virt-manager host configurations. |
| `sleep.nix` | Custom power management and suspend/resume systemd hooks. |

### User Configuration (`modules/home/`)
| File | Description |
|---|---|
| `default.nix` | Home Manager entry point. Handles dotfiles generation and custom app configs. |
| `shell.nix` | Zsh environment, custom aliases, CLI plugins, and prompt configuration. |
| `packages.nix` | User-specific software installations. |
| `desktop.nix` | User-level desktop theming (GTK/Qt, dconf), XDG settings, and MIME types. |

## 🛠️ Installation & Setup

1. **Boot into a NixOS Live Environment.**
2. **Partition & Mount** your drives according to your preferred layout.
3. **Generate Hardware Config:**
   ```bash
   sudo nixos-generate-config --root /mnt
   ```
4. **Copy the hardware configuration** into this repository to replace the placeholder:
   ```bash
   cp /mnt/etc/nixos/hardware-configuration.nix ./hosts/workstation/hardware-configuration.nix
   ```
5. **Install NixOS:**
   ```bash
   sudo nixos-install --flake .#workstation
   ```

## 🔄 Updating the System

After installation, updates and configuration changes are applied centrally using flakes:

```bash
sudo nixos-rebuild switch --flake .#workstation
```
