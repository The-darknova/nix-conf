{ config, pkgs, ... }:

{
  networking.hostName = "darknova";
  # Use NetworkManager instead of wpa_supplicant for Wi-Fi and VPNs
  networking.networkmanager.enable = true;
  networking.networkmanager.plugins = with pkgs; [ networkmanager-openconnect ];

  # VPNs
  services.tailscale.enable = true;

  # Hardening: Firewall Configuration
  networking.nftables.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ ]; # Strict default for laptops
    allowedUDPPorts = [ ];
    # Trust container/VM networks so internal routing isn't blocked
    trustedInterfaces = [ "docker-net-br0" "incusbr0" "virbr0" "virbr1" "virbr2" "virbr3" "tailscale0" ];
  };
}
