{ lib, stdenv, fetchurl, pkg-config, perl
, brotliSupport ? false, brotli
, c-aresSupport ? false, c-aresMinimal
, gnutlsSupport ? false, gnutls
, gsaslSupport ? false, gsasl
, gssSupport ? with stdenv.hostPlatform; (
    !isWindows &&
    # disable gss becuase of: undefined reference to `k5_bcmp'
    # a very sad story re static: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=439039
    !isStatic &&
    # the "mig" tool does not configure its compiler correctly. This could be
    # fixed in mig, but losing gss support on cross compilation to darwin is
    # not worth the effort.
    !(isDarwin && (stdenv.buildPlatform != stdenv.hostPlatform))
  ), libkrb5
, http2Support ? true, nghttp2
, http3Support ? false, nghttp3, ngtcp2
, idnSupport ? false, libidn2
, ipv6Support ? true
, ldapSupport ? false, openldap
, opensslSupport ? zlibSupport, openssl
, pslSupport ? false, libpsl
, rtmpSupport ? false, rtmpdump
, scpSupport ? zlibSupport && !stdenv.isSunOS && !stdenv.isCygwin, libssh2
, wolfsslSupport ? false, wolfssl
, zlibSupport ? true, zlib
, zstdSupport ? false, zstd
}:

# Note: this package is used for bootstrapping fetchurl, and thus
# cannot use fetchpatch! All mutable patches (generated by GitHub or
# cgit) that are needed here should be included directly in Nixpkgs as
# files.

assert !(gnutlsSupport && opensslSupport);
assert !(gnutlsSupport && wolfsslSupport);
assert !(opensslSupport && wolfsslSupport);

stdenv.mkDerivation (finalAttrs: {
  pname = "curl";
  version = "7.86.0";

  src = fetchurl {
    urls = [
      "https://curl.haxx.se/download/curl-${finalAttrs.version}.tar.bz2"
      "https://github.com/curl/curl/releases/download/curl-${finalAttrs.version}/curl-${finalAttrs.version}.tar.bz2"
    ];
    sha256 = "sha256-9cpp2wPuoX+ocFvfsan1jXakbJAQUYEJuzjzExN+Cig=";
  };

  patches = [
    ./patch/7.79.1-darwin-no-systemconfiguration.patch
  ];

  outputs = [ "bin" "dev" "out" "man" "devdoc" ];
  separateDebugInfo = stdenv.isLinux;

  enableParallelBuilding = true;

  strictDeps = true;

  nativeBuildInputs = [ pkg-config perl ];

  # Zlib and OpenSSL must be propagated because `libcurl.la' contains
  # "-lz -lssl", which aren't necessary direct build inputs of
  # applications that use Curl.
  propagatedBuildInputs = with lib;
    optional brotliSupport brotli ++
    optional c-aresSupport c-aresMinimal ++
    optional gnutlsSupport gnutls ++
    optional gsaslSupport gsasl ++
    optional gssSupport libkrb5 ++
    optional http2Support nghttp2 ++
    optionals http3Support [ nghttp3 ngtcp2 ] ++
    optional idnSupport libidn2 ++
    optional ldapSupport openldap ++
    optional opensslSupport openssl ++
    optional pslSupport libpsl ++
    optional rtmpSupport rtmpdump ++
    optional scpSupport libssh2 ++
    optional wolfsslSupport wolfssl ++
    optional zlibSupport zlib ++
    optional zstdSupport zstd;

  # for the second line see https://curl.haxx.se/mail/tracker-2014-03/0087.html
  preConfigure = ''
    sed -e 's|/usr/bin|/no-such-path|g' -i.bak configure
    rm src/tool_hugehelp.c
  '';

  configureFlags = [
      # Build without manual
      "--disable-manual"
      (lib.enableFeature c-aresSupport "ares")
      (lib.enableFeature ldapSupport "ldap")
      (lib.enableFeature ldapSupport "ldaps")
      # The build fails when using wolfssl with --with-ca-fallback
      (lib.withFeature (!wolfsslSupport) "ca-fallback")
      (lib.withFeature http3Support "nghttp3")
      (lib.withFeature http3Support "ngtcp2")
      (lib.withFeature rtmpSupport "librtmp")
      (lib.withFeature zstdSupport "zstd")
      (lib.withFeatureAs brotliSupport "brotli" (lib.getDev brotli))
      (lib.withFeatureAs gnutlsSupport "gnutls" (lib.getDev gnutls))
      (lib.withFeatureAs idnSupport "libidn2" (lib.getDev libidn2))
      (lib.withFeatureAs opensslSupport "openssl" (lib.getDev openssl))
      (lib.withFeatureAs scpSupport "libssh2" (lib.getDev libssh2))
      (lib.withFeatureAs wolfsslSupport "wolfssl" (lib.getDev wolfssl))
    ]
    ++ lib.optional gssSupport "--with-gssapi=${lib.getDev libkrb5}"
    ++ lib.optional (!ipv6Support) "--disable-ipv6"
       # For the 'urandom', maybe it should be a cross-system option
    ++ lib.optional (stdenv.hostPlatform != stdenv.buildPlatform)
       "--with-random=/dev/urandom"
    ++ lib.optionals stdenv.hostPlatform.isWindows [
      "--disable-shared"
      "--enable-static"
    ] ++ lib.optionals stdenv.isDarwin [
      # Disable default CA bundle, use NIX_SSL_CERT_FILE or fallback to nss-cacert from the default profile.
      # Without this curl might detect /etc/ssl/cert.pem at build time on macOS, causing curl to ignore NIX_SSL_CERT_FILE.
      "--without-ca-bundle"
      "--without-ca-path"
    ];

  CXX = "${stdenv.cc.targetPrefix}c++";
  CXXCPP = "${stdenv.cc.targetPrefix}c++ -E";

  doCheck = false; # expensive, fails

  postInstall = ''
    moveToOutput bin/curl-config "$dev"

    # Install completions
    make -C scripts install
  '' + lib.optionalString scpSupport ''
    sed '/^dependency_libs/s|${lib.getDev libssh2}|${lib.getLib libssh2}|' -i "$out"/lib/*.la
  '' + lib.optionalString gnutlsSupport ''
    ln $out/lib/libcurl${stdenv.hostPlatform.extensions.sharedLibrary} $out/lib/libcurl-gnutls${stdenv.hostPlatform.extensions.sharedLibrary}
    ln $out/lib/libcurl${stdenv.hostPlatform.extensions.sharedLibrary} $out/lib/libcurl-gnutls${stdenv.hostPlatform.extensions.sharedLibrary}.4
    ln $out/lib/libcurl${stdenv.hostPlatform.extensions.sharedLibrary} $out/lib/libcurl-gnutls${stdenv.hostPlatform.extensions.sharedLibrary}.4.4.0
  '';

  passthru = let
    useThisCurl = attr: attr.override { curl = finalAttrs.finalPackage; };
  in {
    inherit opensslSupport openssl;
  };

  meta = with lib; {
    description = "A command line tool for transferring files with URL syntax";
    homepage    = "https://curl.se/";
    license = licenses.curl;
    maintainers = with maintainers; [ lovek323 ];
    platforms = platforms.all;
    # Fails to link against static brotli or gss
    broken = stdenv.hostPlatform.isStatic && (brotliSupport || gssSupport);
  };
})
