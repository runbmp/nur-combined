{ lib, buildPackages, callPackage, fetchFromGitHub, fetchYarnDeps, mkYarnPackage }:
let
  common = callPackage ./common.nix { };

  esbuild_0_17_12 = buildPackages.esbuild.overrideAttrs (_: rec {
    version = "0.17.12";

    src = fetchFromGitHub {
      owner = "evanw";
      repo = "esbuild";
      rev = "v${version}";
      hash = "sha256-75qDQWAp6cmuXtq90oIIQCj5IKUoQxNARxhFo2Sm5mk=";
    };

    vendorHash = "sha256-+BfxCyg0KkDQpHt/wycy/8CTG6YBA/VJvJFhhzUnSiQ=";
  });
in
mkYarnPackage {
  pname = "woodpecker-frontend";
  inherit (common) version;

  src = "${common.src}/web";

  packageJSON = ./woodpecker-package.json;
  yarnLock = ./yarn.lock;

  offlineCache = fetchYarnDeps {
    yarnLock = ./yarn.lock;
    hash = common.yarnHash;
  };

  ESBUILD_BINARY_PATH = lib.getExe esbuild_0_17_12;

  buildPhase = ''
    runHook preBuild

    yarn --offline build

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    cp -R deps/woodpecker-ci/dist $out
    echo "${common.version}" > "$out/version"

    runHook postInstall
  '';

  # Do not attempt generating a tarball for woodpecker-frontend again.
  doDist = false;

  meta = common.meta // {
    description = "Woodpecker Continuous Integration server frontend";
  };
}
