# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  lib,
  pkgs,
  ...
}: let
  secrets = config.my.secrets;
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    ./home.nix
    ./secrets.nix
  ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  boot.supportedFilesystems = ["btrfs"];

  services.btrfs = {
    autoScrub = {
      enable = true;
      fileSystems = ["/"];
    };
  };

  networking.hostName = "poseidon"; # Define your hostname.
  networking.domain = "alarsyo.net";

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno1.ipv4.addresses = [
    {
      address = "163.172.11.110";
      prefixLength = 24;
    }
  ];
  networking.defaultGateway = {
    address = "163.172.11.1";
    interface = "eno1";
  };
  networking.nameservers = [
    "62.210.16.6"
    "62.210.16.7"
  ];
  my.networking.externalInterface = "eno1";

  my.services = {
    vaultwarden = {
      enable = true;
      privatePort = 8081;
      websocketPort = 3012;
    };

    restic-backup = {
      enable = true;
      repo = "b2:poseidon-backup";
      passwordFile = config.age.secrets."restic-backup/poseidon-password".path;
      environmentFile = config.age.secrets."restic-backup/poseidon-credentials".path;
    };

    fail2ban = {
      enable = true;
    };

    lohr = {
      enable = true;
      port = 8083;
    };

    tailscale = {
      enable = true;
      exitNode = true;
    };
  };

  services = {
    openssh.enable = true;
    vnstat.enable = true;
  };

  # Takes a long while to build
  documentation.nixos.enable = false;
}
