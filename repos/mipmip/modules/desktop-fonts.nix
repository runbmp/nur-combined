{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    meslo-lg
    awesome
    dejavu_fonts
    open-sans
    inter
  ];

  fonts.fonts = with pkgs; [
    open-sans
    meslo-lg
    awesome
    dejavu_fonts
  ];


}

