# This file is a modified version of nixpkgs/pkgs/applications/networking/instant-messengers/nheko/default.nix (copied at 2e896fce)

{ lib
, stdenv
, fetchFromGitHub
, cmake
, wrapQtAppsHook
, asciidoctor
, boost17x
, cmark
, coeurl
, curl
, libevent
, libsecret
, lmdb
, lmdbxx
, mkDerivation
, mtxclient
, nlohmann_json
, olm
, pkg-config
, qtbase
, qtgraphicaleffects
, qtimageformats
, qtkeychain
, qtmultimedia
, qtquickcontrols2
, qttools
, re2
, spdlog
, qtmacextras
, voipSupport ? true
, gst_all_1
, libnice
}:

mkDerivation {
  pname = "nheko";
  version = "unstable-2023-05-06";

  src = fetchFromGitHub {
    owner = "Nheko-Reborn";
    repo = "nheko";
    rev = "0a55c8ee175c9538849b81f7a47779c101d355ca";
    hash = "sha256-kIx43kyFEI2KWbGNVfqjLkZ4v2W3MXXQZkV5qLwnBIY=";
  };

  nativeBuildInputs = [
    lmdbxx
    cmake
    pkg-config
    asciidoctor
    wrapQtAppsHook
  ];

  buildInputs = [
    boost17x
    cmark
    coeurl
    curl
    libevent
    libsecret
    lmdb
    mtxclient
    nlohmann_json
    olm
    qtbase
    qtgraphicaleffects
    qtimageformats
    qtkeychain
    qtmultimedia
    qtquickcontrols2
    qttools
    re2
    spdlog
  ] ++ lib.optional stdenv.isDarwin qtmacextras
    ++ lib.optionals voipSupport (with gst_all_1; [
      gstreamer
      gst-plugins-base
      (gst-plugins-good.override { qt5Support = true; })
      gst-plugins-bad
      libnice
    ]);

  cmakeFlags = [
    "-DCOMPILE_QML=ON" # see https://github.com/Nheko-Reborn/nheko/issues/389
    "-DCMAKE_BUILD_TYPE=Release"
    "-DBUILD_SHARED_LIBS=OFF"
  ];


  preFixup = lib.optionalString voipSupport ''
    # add gstreamer plugins path to the wrapper
    qtWrapperArgs+=(--prefix GST_PLUGIN_SYSTEM_PATH_1_0 : "$GST_PLUGIN_SYSTEM_PATH_1_0")
  '';

  meta = with lib; {
    description = "Desktop client for the Matrix protocol";
    homepage = "https://github.com/Nheko-Reborn/nheko";
    platforms = platforms.all;
    license = licenses.gpl3Plus;
  };
}
