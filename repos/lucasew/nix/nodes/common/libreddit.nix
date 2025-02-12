{ lib, config, ... }:
lib.mkIf config.services.libreddit.enable {
  networking.ports.libreddit.enable = true;

  services.libreddit = {
    inherit (config.networking.ports.libreddit) port;
  };

  services.nginx.virtualHosts."libreddit.${config.networking.hostName}.${config.networking.domain}" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString config.services.libreddit.port}";
      proxyWebsockets = true;
    };
  };
}
