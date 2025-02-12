{ pkgs, lib, config, ... }:
let
  cfg = config.services.cf-torrent;
  inherit (lib) mkEnableOption mkOption types mkIf mkDefault;
in {
  options.services.cf-torrent = {
    enable = mkEnableOption "cf-torrent";
    package = mkOption {
      description = "Which cf-torrent package to use";
      default = pkgs.callPackage pkgs.bumpkin.unpackedInputs.cf-torrent.outPath {};
      type = types.package;
    };
    port = mkOption {
      description = "Port for cf-torrent";
      default = config.networking.ports.cf-torrent.port;
      type = types.port;
    };
  };

  config = mkIf cfg.enable {
    networking.ports.cf-torrent.enable = mkDefault true;

    services.cf-torrent.port = mkDefault config.networking.ports.cf-torrent.port;

    services.nginx.virtualHosts."cf-torrent.${config.networking.hostName}.${config.networking.domain}" = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString cfg.port}";
        proxyWebsockets = true;
      };
    };
    systemd.services.cf-torrent = {
      inherit (cfg.package.meta) description;
      wantedBy = [ "multi-user.target" ];
      environment = {
        PORT="${toString cfg.port}";
      };
      script = ''
        ${cfg.package}/bin/*
      '';
    };
  };
}
