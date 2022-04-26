# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: let
  inherit
    (lib)
    mkDefault
    ;
in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/6395cef1-c30b-450a-917c-cfb3c0380642";
    fsType = "btrfs";
    options = ["subvol=@" "compress=zstd" "noatime"];
  };

  boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-uuid/c59e7067-e33c-474c-9b8e-96d0e8f59297";

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/6395cef1-c30b-450a-917c-cfb3c0380642";
    fsType = "btrfs";
    options = ["subvol=@home" "compress=zstd" "noatime"];
    neededForBoot = true; # agenix needs my key for some root secrets
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/6395cef1-c30b-450a-917c-cfb3c0380642";
    fsType = "btrfs";
    options = ["subvol=@nix" "compress=zstd" "noatime"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/D9DA-F46C";
    fsType = "vfat";
  };

  fileSystems."/swap" = {
    device = "/dev/disk/by-uuid/6395cef1-c30b-450a-917c-cfb3c0380642";
    fsType = "btrfs";
    options = ["subvol=@swap" "compress=zstd" "noatime"];
  };

  swapDevices = [
    {
      device = "/swap/swapfile";
      size = 1024 * 8; # half of RAM size
    }
  ];

  powerManagement.cpuFreqGovernor = mkDefault "powersave";

  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
  };
}
