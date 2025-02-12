{ config, lib, pkgs, hostname, inputs, ... }:

let
  inherit (lib) mkForce;
  inherit (inputs) self;
  system-lib = import "${self}/system/lib" { inherit inputs; };
  inherit (system-lib) obtainIPV4Address obtainIPV4GatewayAddress;

in {
  imports =
    [
      ./disk-setup.nix
      ./hardware-configuration.nix
      "${self}/system/profiles/sets/workstation.nix"
    ];

  networking = {
    interfaces.enp5s0 = {
      useDHCP = false;
      ipv4.addresses = [ {
        address = obtainIPV4Address hostname "brume";
        prefixLength = 24;
      } ];
    };
    defaultGateway = {
      address = (obtainIPV4GatewayAddress "brume" "1");
      interface = "enp5s0";
    };
  };

  profile = {
    gaming = {
      enable = true;
      useSteamHardware = true;
    };
    moonlander = {
      enable = true;
      ignoreLayoutSettings = true;
    };
    nix = {
      enableAutoOptimise = true;
      enableFlakes = true;
      enableUseSandbox = true;
    };
    sound = {
      enable = true;
      enableOSSEmulation = true;
      pipewire = {
        enable = true;
        enableAlsa32BitSupport = true;
      };
    };
    virtualization = {
      podman.enable = true;
      qemu = {
        enable = true;
        extraPkgs = with pkgs; [ virt-manager ];
        libvirtdGroupMembers = [ "bjorn" ];
      };
    };
    specialisations.work.simplerisk.enable = true;
  };

  sops.secrets."machine_id" = {
    sopsFile = ./secrets.yml;
    mode = "0644";
  };

  #environment.etc.machine-id.source = config.sops.secrets."machine_id".path;

  system.stateVersion = "22.11"; # Did you read the comment?

}
