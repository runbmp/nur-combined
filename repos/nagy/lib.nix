{ pkgs, lib ? pkgs.lib, ... }:

with builtins;
with lib; rec {
  gltf-pipeline = let
    mypkgs = (import (pkgs.fetchFromGitHub {
      owner = "nagy";
      repo = "nixpkgs";
      rev = "946704823d74346749656fb80c208716cf600c02";
      hash = "sha256-AY1AFFOirNQS6VM6DXit50mPpzwH6zefNJOIB41JKCA=";
    }) { });
  in mypkgs.nodePackages.gltf-pipeline;

  mkGlb2Gltf = src:
    let
      isFile = hasSuffix ".glb" (toString (baseNameOf src));
      thename = if isFile then
        replaceStrings [ ".glb" ] [ ".gltf" ] (toString (baseNameOf src))
      else
        "gltf-outputs";
      thesrc = if isFile then src else cleanSource src;
    in pkgs.runCommand thename {
      nativeBuildInputs = [ gltf-pipeline ];
      src = thesrc;
    } ''
      if [[ -d $src ]]; then
        cd -- $src
        for g in *.glb; do
          gltf-pipeline --input $g --output $out/${"$"}{g%.glb}.gltf
        done
      else
        gltf-pipeline --input $src --output $out
      fi
    '';
}
