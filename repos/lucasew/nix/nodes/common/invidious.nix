{ config, lib, ... }:
lib.mkIf config.services.invidious.enable {
  networking.ports.invidious.enable = true;
  services.invidious = {
    inherit (config.networking.ports.invidious) port;
  };

  services.nginx.virtualHosts."invidious.${config.networking.hostName}.${config.networking.domain}" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString config.networking.ports.invidious.port}";
      proxyWebsockets = true;
    };
  };
}

