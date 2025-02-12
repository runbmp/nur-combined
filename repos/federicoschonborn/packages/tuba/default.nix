{ lib
, stdenv
, fetchFromGitHub
, desktop-file-utils
, meson
, ninja
, pkg-config
, vala
, wrapGAppsHook4
, gtk4
, gtksourceview5
, json-glib
, libadwaita
, libgee
, libsecret
, libsoup_3
, libwebp
, libxml2
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "tuba";
  version = "0.3.2";

  src = fetchFromGitHub {
    owner = "GeopJr";
    repo = "Tuba";
    rev = "v${finalAttrs.version}";
    hash = "sha256-PSEPpJn/lYpeI6AN2AY73NpOcDkMm0zNqeSdELn5HvY=";
  };

  nativeBuildInputs = [
    desktop-file-utils
    meson
    ninja
    pkg-config
    vala
    wrapGAppsHook4
  ];

  buildInputs = [
    gtk4
    gtksourceview5
    json-glib
    libadwaita
    libgee
    libsecret
    libsoup_3
    libwebp
    libxml2
  ];

  meta = with lib; {
    description = "Browse the Fediverse";
    mainProgram = "dev.geopjr.Tuba";
    homepage = "https://github.com/GeopJr/Tuba";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ federicoschonborn ];
  };
})
