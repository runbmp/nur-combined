{ lib, fetchFromGitHub, python3Packages, withUI ? true }:

python3Packages.buildPythonApplication rec {
  pname = "gt4gd";
  version = "1.3.5";

  src = fetchFromGitHub {
    owner = "xinebf";
    repo = "google-translate-for-goldendict";
    rev = "v${version}";
    hash = "sha256-1WZo2pDYLUN4BgbYfTsrAZpWvNgixILkVL0NWlTCkRU=";
  };

  propagatedBuildInputs = with python3Packages; [ requests ]
    ++ lib.optional withUI tkinter;

  doCheck = false;

  postInstall = lib.optionalString withUI ''
    install -Dm755 googletranslateui.py $out/bin/googletranslateui
    install -Dm644 google_translate.png -t $out/share/gt4gd
  '';

  meta = with lib; {
    description = "Add Google translate to GoldenDict";
    inherit (src.meta) homepage;
    license = licenses.gpl3;
    maintainers = [ maintainers.sikmir ];
  };
}
