{ config, pkgs, ... }:

{
  # Virtualization & Containerization
  virtualisation.docker.enable = true;
  environment.systemPackages = with pkgs; [ virtiofsd ];
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      vhostUserPackages = [ pkgs.virtiofsd ];
    };
  };
  virtualisation.spiceUSBRedirection.enable = true;
  programs.virt-manager.enable = true;
  
  # Incus Configuration
  virtualisation.incus = {
    enable = true;
    ui.enable = true;
    preseed = {
      config = {
        "core.https_address" = ":10443";
      };
      networks = [
        {
          name = "incusbr0";
          type = "bridge";
          config = {
            "ipv4.address" = "11.0.200.1/24";
            "ipv4.nat" = "true";
            "ipv6.address" = "none";
          };
        }
      ];
      profiles = [
        {
          name = "default";
          devices = {
            eth0 = {
              name = "eth0";
              network = "incusbr0";
              type = "nic";
            };
            root = {
              path = "/";
              pool = "default";
              size = "35GiB";
              type = "disk";
            };
          };
        }
      ];
      storage_pools = [
        {
          name = "default";
          driver = "btrfs";
          config = {
            source = "/var/lib/incus/storage-pools/default";
          };
        }
      ];
    };
  };
}
