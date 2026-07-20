{ config, pkgs, lib, ... }:

let
  # Containers that must wait for the custom Docker network to be ready.
  # The reverse-shell-generator is handled separately (it needs a custom build step).
  networkDependentContainers = [
    "docker-nginx-proxy-manager"
    "docker-portainer"
    "docker-portainer-agent"
    "docker-homer"
    "docker-it-tools"
    "docker-cyberchef"
    "docker-fossflow"
  ];

  # Common network dependency attrs, applied to each container in the list above.
  networkDep = {
    after    = [ "docker-network-br0.service" ];
    requires = [ "docker-network-br0.service" ];
  };
in
{
  # ---------------------------------------------------------------------------
  # Local DNS Aliases
  # ---------------------------------------------------------------------------

  networking.hosts = {
    "127.0.0.1" = [
      "darknova.local"
      "portainer.darknova.local"
      "homer.darknova.local"
      "it-tools.darknova.local"
      "cyberchef.darknova.local"
      "reverse-shell.darknova.local"
      "npm.darknova.local"
      "fossflow.darknova.local"
    ];
  };

  # ---------------------------------------------------------------------------
  # Compose Directory Permissions
  # ---------------------------------------------------------------------------

  system.activationScripts.fixComposePermissions = ''
    mkdir -p /opt/compose
    chown -R root:docker /opt/compose
    chmod -R g+rwX /opt/compose
  '';

  # ---------------------------------------------------------------------------
  # OCI Containers
  # ---------------------------------------------------------------------------

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

      portainer-agent = {
        image = "portainer/agent:latest";
        extraOptions = [ "--network=docker-net-br0" ];
        volumes = [
          "/var/run/docker.sock:/var/run/docker.sock"
          "/var/lib/docker/volumes:/var/lib/docker/volumes"
          "/:/host"
        ];
      };

      homer = {
        image = "b4bz/homer:latest";
        user = "1000:1000";
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

      fossflow = {
        image = "stnsmith/fossflow:latest";
        extraOptions = [ "--network=docker-net-br0" ];
        volumes = [
          "/opt/compose/fossflow/diagrams:/data/diagrams"
        ];
      };

      reverse-shell-generator = {
        image = "reverse-shell-generator:local";
        extraOptions = [ "--network=docker-net-br0" ];
      };
    };
  };

  # ---------------------------------------------------------------------------
  # Systemd Services
  # ---------------------------------------------------------------------------

  systemd.services = lib.mkMerge [
    # Custom Docker bridge network — created before any container starts.
    {
      docker-network-br0 = {
        description = "Create custom Docker bridge network docker-net-br0";
        wantedBy = [ "multi-user.target" ];
        after    = [ "docker.service" ];
        requires = [ "docker.service" ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          # Leading "-" means non-zero exit is ignored (network may already exist).
          ExecStart = "-${pkgs.docker}/bin/docker network create --driver bridge --subnet 172.200.0.0/16 docker-net-br0";
        };
      };
    }

    # Apply network dependency to all standard containers via lib.genAttrs
    # instead of repeating the same two lines for each service.
    (lib.genAttrs networkDependentContainers (_: networkDep))

    # Reverse-shell-generator: also needs a preStart build step.
    {
      "docker-reverse-shell-generator" = networkDep // {
        path     = [ pkgs.git pkgs.docker ];
        preStart = ''
          if ! docker image inspect reverse-shell-generator:local > /dev/null 2>&1; then
            workdir=$(mktemp -d)
            git clone https://github.com/0dayCTF/reverse-shell-generator.git $workdir
            docker build -t reverse-shell-generator:local $workdir
            rm -rf $workdir
          fi
        '';
      };
    }
  ];
}
