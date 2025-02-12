{self, global, pkgs, config, lib, unpackedInputs, ...}@args:
let
  inherit (self) inputs;
  inherit (global) username;
  hostname = "whiterun";
in {
  imports = [
    ./hardware-configuration.nix
    ../gui-common

    "${unpackedInputs.nixos-hardware}/common/cpu/amd/pstate.nix"
    "${unpackedInputs.nixos-hardware}/common/gpu/amd"
    "${unpackedInputs.nixos-hardware}/common/pc/ssd"

    # "${unpackedInputs.nixos-hardware}/common/gpu/nvidia"
    ./dashboards.nix
    ./dlna.nix
    ./nextcloud.nix
    ./postgresql.nix
    ./rocm-gambiarra.nix
    ./sshfs.nix
    ./zfs.nix
  ];

  services.transmission.enable = true;
  systemd.services.transmission.serviceConfig.BindPaths = [
    "/storage/downloads"
  ];

  services.cf-torrent.enable = true;

  boot.plymouth.enable = true;

  services.libreddit.enable = true;
  services.invidious.enable = true;

  services.boinc.enable = true;

  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = "lucasew";
  };

  services.flatpak.enable = true;

  networking.hostId = "97e3b5a7";

  virtualisation.oci-containers.backend = "docker";

  services.kubo.enable = true;

  services.telegram-sendmail.enable = true;

  services.cloud-savegame = {
    enable = true;
    calendar = "00:00:01";
  };

  services.nextcloud.enable = true;

  services.cockpit.enable = true;

  services.magnetico.enable = true;

  services.jellyfin-container = {
    enable = true;
    mediaDirs = {
      transmission = "/var/lib/transmission/Downloads";
      storage_movies = "/storage/downloads/filmes";
      storage_series = "/storage/downloads/series";
    };
  };

  boot = {
    supportedFilesystems = [ "ntfs" ];
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        efiSupport = true;
        device = "nodev";
        # useOSProber = true; # TODO: test that VM scheme with SATA passthrough first
      };
    };
  };
  hardware.opengl.driSupport = true;
  hardware.opengl.extraPackages = with pkgs; [
     rocm-runtime
     rocm-opencl-icd
     rocm-opencl-runtime
  ];
  hardware.opengl.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];

  programs.steam.enable = true;

  networking.hostName = hostname;

  boot.kernelPackages = pkgs.linuxPackages_6_1;

  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  services.openssh.settings.X11Forwarding = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
