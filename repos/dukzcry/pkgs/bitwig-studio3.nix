{ stdenv, fetchurl, alsa-lib, cairo, dpkg, freetype
, gdk-pixbuf, glib, gtk3, lib, xorg
, libglvnd, libjack2, ffmpeg
, libxkbcommon_7, xdg-utils, zlib, pulseaudio
, wrapGAppsHook, makeWrapper }:

stdenv.mkDerivation rec {
  pname = "bitwig-studio";
  version = "3.1.3";

  src = fetchurl {
    url = "https://downloads.bitwig.com/stable/${version}/${pname}-${version}.deb";
    sha256 = "11z5flmp55ywgxyccj3pzhijhaggi42i2pvacg88kcpj0cin57vl";
  };

  nativeBuildInputs = [ dpkg makeWrapper wrapGAppsHook ];

  unpackCmd = ''
    mkdir -p root
    dpkg-deb -x $curSrc root
  '';

  dontBuild = true;
  dontWrapGApps = true; # we only want $gappsWrapperArgs here

  buildInputs = with xorg; [
    alsa-lib cairo freetype gdk-pixbuf glib gtk3 libxcb xcbutil xcbutilwm zlib libXtst libxkbcommon_7 pulseaudio libjack2 libX11 libglvnd libXcursor stdenv.cc.cc.lib
  ];

  binPath = lib.makeBinPath [
    xdg-utils ffmpeg
  ];

  ldLibraryPath = lib.strings.makeLibraryPath buildInputs;

  installPhase = ''
    mkdir -p $out/bin
    cp -r opt/bitwig-studio $out/libexec
    ln -s $out/libexec/bitwig-studio $out/bin/bitwig-studio
    cp -r usr/share $out/share
    substitute usr/share/applications/bitwig-studio.desktop \
      $out/share/applications/bitwig-studio.desktop \
      --replace /usr/bin/bitwig-studio $out/bin/bitwig-studio
  '';

  postFixup = ''
    # patchelf fails to set rpath on BitwigStudioEngine, so we use
    # the LD_LIBRARY_PATH way

    find $out -type f -executable \
      -not -name '*.so.*' \
      -not -name '*.so' \
      -not -name '*.jar' \
      -not -path '*/resources/*' | \
    while IFS= read -r f ; do
      patchelf --set-interpreter "${stdenv.cc.bintools.dynamicLinker}" $f
      wrapProgram $f \
        "''${gappsWrapperArgs[@]}" \
        --prefix PATH : "${binPath}" \
        --prefix LD_LIBRARY_PATH : "${ldLibraryPath}" \
        --set LD_PRELOAD "${libxkbcommon_7.out}/lib/libxkbcommon.so" || true
    done

  '';

  meta = with lib; {
    description = "A digital audio workstation";
    longDescription = ''
      Bitwig Studio is a multi-platform music-creation system for
      production, performance and DJing, with a focus on flexible
      editing tools and a super-fast workflow.
    '';
    homepage = "https://www.bitwig.com/";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
    maintainers = with maintainers; [ ];
  };
}
