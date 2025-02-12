{ lib, stdenv, fetchfossil, libGL, libX11, SDL, ghostscript, sqlite, memstreamHook }:

stdenv.mkDerivation {
  pname = "farbfeld-utils";
  version = "2022-12-16";

  src = fetchfossil {
    url = "http://zzo38computer.org/fossil/farbfeld.ui";
    rev = "499eb1854cf8695353abc10621d7b0d66e8064f8";
    sha256 = "sha256-I1o94L2up9eByH38aCW756sSzPrPhnGFDeOOQmPu/cU=";
  };

  postPatch = lib.optionalString stdenv.isDarwin ''
    rm ff-vccapture.c ff-xcapture.c ff-xdraw.c ff-xwin.c
  '';

  buildInputs = [ libGL SDL ghostscript sqlite ]
    ++ lib.optional stdenv.isLinux libX11
    ++ lib.optional stdenv.isDarwin memstreamHook;

  buildPhase = ''
    runHook preBuild

    mkdir -p $out/bin
    $CC -c lodepng.c
    find . -name '*.c' -exec grep 'gcc' {} + -print0 | \
      awk -F: '{print $2}' | sed 's#~/bin#$out/bin#;s#gcc#$CC#;s#/usr/lib/libgs.so.9#-lgs#' | xargs -0 sh -c

    runHook postBuild
  '';

  dontInstall = true;

  meta = with lib; {
    description = "Collection of utilities for farbfeld picture format";
    homepage = "http://zzo38computer.org/fossil/farbfeld.ui/home";
    license = licenses.publicDomain;
    maintainers = [ maintainers.sikmir ];
    platforms = platforms.unix;
    broken = stdenv.isDarwin; # mesa is broken
  };
}
