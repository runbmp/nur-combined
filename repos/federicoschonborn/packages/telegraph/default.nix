{ lib
, python3Packages
, fetchFromGitHub
, desktop-file-utils
, gtk4
, libadwaita
, meson
, ninja
, pkg-config
, wrapGAppsHook4
}:

python3Packages.buildPythonApplication rec {
  pname = "telegraph";
  version = "0.1.6";

  format = "other";

  src = fetchFromGitHub {
    owner = "fkinoshita";
    repo = "Telegraph";
    rev = version;
    hash = "sha256-eYivvuycMhBC9MMJHugTsZUu5M7V8AbkQUWsfybHETU=";
  };

  nativeBuildInputs = [
    desktop-file-utils
    meson
    ninja
    pkg-config
    wrapGAppsHook4
  ];

  buildInputs = [
    gtk4
    libadwaita
  ];

  propagatedBuildInputs = with python3Packages; [
    pygobject3
  ];

  dontWrapGApps = true;
  preFixup = ''
    makeWrapperArgs+=("''${gappsWrapperArgs[@]}")
  '';

  meta = with lib; {
    description = "Write and decode morse";
    homepage = "https://github.com/fkinoshita/Telegraph";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ federicoschonborn ];
  };
}
