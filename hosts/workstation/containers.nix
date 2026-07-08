{ config, pkgs, ... }:

{
  networking.hosts = {
    "127.0.0.1" = [
      "portainer.darknova.local"
      "homer.darknova.local"
      "it-tools.darknova.local"
      "cyberchef.darknova.local"
      "reverse-shell.darknova.local"
      "npm.darknova.local"
    ];
  };

  systemd.services.docker-network-br0 = {
    description = "Create custom Docker Network docker-net-br0";
    wantedBy = [ "multi-user.target" ];
    after = [ "docker.service" ];
    requires = [ "docker.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "-${pkgs.docker}/bin/docker network create --driver bridge --subnet 172.200.0.0/16 docker-net-br0";
    };
  };

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      nginx-proxy-manager = {
        image = "jc21/nginx-proxy-manager:latest";
        extraOptions = [ "--network=docker-net-br0" ];
        ports = [ 
          "127.0.0.1:80:80" 
          "127.0.0.1:81:81" 
          "127.0.0.1:443:443" 
        ];
        volumes = [
          "/opt/compose/nginx-proxy-manager/data:/data"
          "/opt/compose/nginx-proxy-manager/letsencrypt:/etc/letsencrypt"
        ];
      };

      portainer = {
        image = "portainer/portainer-ce:latest";
        extraOptions = [ "--network=docker-net-br0" ];
        volumes = [
          "/var/run/docker.sock:/var/run/docker.sock"
          "/opt/compose/portainer/data:/data"
        ];
      };

      homer = {
        image = "b4bz/homer:latest";
        extraOptions = [ "--network=docker-net-br0" ];
        volumes = [
          "/opt/compose/homer/assets:/www/assets"
        ];
      };

      it-tools = {
        image = "corentinth/it-tools:latest";
        extraOptions = [ "--network=docker-net-br0" ];
      };

      cyberchef = {
        image = "ghcr.io/gchq/cyberchef:latest";
        extraOptions = [ "--network=docker-net-br0" ];
      };

      reverse-shell-generator = {
        image = "0dayctf/reverse-shell-generator:latest";
        extraOptions = [ "--network=docker-net-br0" ];
      };
    };
  };

  # Ensure the network is created before starting the containers
  systemd.services."docker-nginx-proxy-manager".after = [ "docker-network-br0.service" ];
  systemd.services."docker-nginx-proxy-manager".requires = [ "docker-network-br0.service" ];

  systemd.services."docker-portainer".after = [ "docker-network-br0.service" ];
  systemd.services."docker-portainer".requires = [ "docker-network-br0.service" ];

  systemd.services."docker-homer".after = [ "docker-network-br0.service" ];
  systemd.services."docker-homer".requires = [ "docker-network-br0.service" ];

  systemd.services."docker-it-tools".after = [ "docker-network-br0.service" ];
  systemd.services."docker-it-tools".requires = [ "docker-network-br0.service" ];

  systemd.services."docker-cyberchef".after = [ "docker-network-br0.service" ];
  systemd.services."docker-cyberchef".requires = [ "docker-network-br0.service" ];

  systemd.services."docker-reverse-shell-generator".after = [ "docker-network-br0.service" ];
  systemd.services."docker-reverse-shell-generator".requires = [ "docker-network-br0.service" ];
}
