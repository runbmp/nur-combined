# DO NOT EDIT. This file was auto generated by ../scripts/generate-pkg.sh
{ pkgs ? import <nixpkgs> { } }:

pkgs.stdenv.mkDerivation {
  name = "languagetool-code-comments";
  src = pkgs.fetchurl {
    url = "https://github.com/dustinblackman/languagetool-code-comments/releases/download/v0.4.0/languagetool-code-comments_0.4.0_linux_amd64.tar.gz";
    sha256 = "07lni34d7zhmni7sj2z4vqwz7nlklwaszi3a0ahgw2llm5z5kq8h";
  };
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p $out/bin
    tar -zxf $src -C $out/bin/ languagetool-code-comments
  '';
}

