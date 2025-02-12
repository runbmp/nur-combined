{ modules, inputs, ... }:
{ config, pkgs, lib, ... }:
let
  modules-enable = with modules; [
    audio
    avahi
    bluetooth
    clash
    common
    croc
    direnv
    fcitx5
    firefox
    fish
    fonts
    genymotion
    git
    grub
    gtk
    liferea
    neovim
    nix
    nix-serve
    podman
    smartdns
    sops
    spotify
    sway
    users
    vscode
    waybar
  ];
in
{
  imports = map (x: x.default or { }) modules-enable ++
    (with inputs; [
      nix-index-database.nixosModules.nix-index
      { programs.command-not-found.enable = false; }
    ]);

  home-manager.users.nixos.imports = map (x: x.home or { }) modules-enable;

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  nix.settings.extra-platforms = [ "aarch64-linux" ];
  boot.supportedFilesystems = [ "ntfs" ];

  networking = {
    firewall.enable = false;
    proxy = {
      default = "http://127.0.0.1:7890";
      noProxy = "127.0.0.1,localhost,.local";
    };
  };

  nix.settings.cores = 11;
  services.earlyoom.enable = true;

  programs.adb.enable = true;

  environment.systemPackages = with pkgs; [
    alacritty
    bottom
    clang
    curl
    dogdns
    gammastep
    git
    hydra-check
    hyperfine
    keepassxc
    killall
    librespeed-cli
    meld
    motrix
    nali
    neovim
    nix-tree
    nixpkgs-fmt
    nvfetcher
    okular
    p7zip
    pavucontrol
    pciutils
    safeeyes
    tdesktop
    tealdeer
    unrar
    unzip
    usbutils
    vlc
    wget
    xdg-utils
    yt-dlp
    zip
    config.nur.repos.xddxdd.qbittorrent-enhanced-edition
  ] ++ (map makeNoProxyWrapper [
    ydict
    ungoogled-chromium
  ]);

  environment.etc."sway/config.d/misc.conf".text = ''
    exec --no-startup-id XDG_SESSION_TYPE=x11 qbittorrent
    exec --no-startup-id gammastep -l 31:121
    exec motrix
    exec safeeyes
  '';
}
