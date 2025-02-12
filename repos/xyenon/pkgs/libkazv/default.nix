{ lib
, stdenv
, fetchFromGitHub
, fetchFromGitLab
, cmake
, pkg-config
, boost
, openssl
, curl
, nlohmann_json
, olm
, cryptopp
, catch2_3
}:

let
  immer = stdenv.mkDerivation {
    name = "immer";
    version = "unstable";
    src = fetchFromGitHub {
      owner = "arximboldi";
      repo = "immer";
      rev = "5e9fe0b3476d1036824fc8934433ba3ddc85a90f";
      hash = "sha256-6Re9+9upHW73k2q/lp65Azu06au1vw609U9QS8XXIO8=";
    };
    nativeBuildInputs = [ cmake ];
    cmakeFlags = [
      "-Dimmer_BUILD_TESTS=ON"
      "-Dimmer_BUILD_EXAMPLES=OFF"
      "-Dimmer_BUILD_DOCS=OFF"
      "-Dimmer_BUILD_EXTRAS=OFF"
    ];
    meta = with lib; {
      homepage = "http://sinusoid.es/immer";
      description = "Postmodern immutable and persistent data structures for C++ — value semantics at scale";
      license = licenses.boost;
    };
  };

  zug = stdenv.mkDerivation {
    name = "zug";
    version = "unstable";
    src = fetchFromGitHub {
      owner = "arximboldi";
      repo = "zug";
      rev = "d7e814b45fceceee3cb1442997d8b46cee4764ec";
      hash = "sha256-zImjvOEW05lAPDcSWvGmWe2SyEdTyfj/DMgOc2C+hPM=";
    };
    nativeBuildInputs = [ cmake ];
    buildInputs = [ boost ];
    cmakeFlags = [ "-Dzug_BUILD_TESTS=ON" "-Dzug_BUILD_EXAMPLES=OFF" "-Dzug_BUILD_DOCS=OFF" ];
    meta = with lib; {
      homepage = "https://github.com/arximboldi/zug";
      description = "Transducers for C++ — Clojure style higher order push/pull sequence transformations";
      license = licenses.boost;
    };
  };

  lager = stdenv.mkDerivation {
    name = "lager";
    version = "unstable";
    src = fetchFromGitHub {
      owner = "arximboldi";
      repo = "lager";
      rev = "8fd338d6d67dd2efc4f38c0634c2f849a7db8774";
      hash = "sha256-SJ3+DjMQ3ZRUtCov9rscNhk4Zsdqizcz4ae3szs/wro=";
    };
    nativeBuildInputs = [ cmake pkg-config ];
    buildInputs = [ boost immer zug ];
    cmakeFlags = [ "-Dlager_BUILD_TESTS=ON" "-Dlager_BUILD_EXAMPLES=OFF" "-Dlager_BUILD_DOCS=OFF" ];
    meta = with lib; {
      homepage = "https://github.com/arximboldi/lager";
      description = "C++ library for value-oriented design using the unidirectional data-flow architecture — Redux for C++";
      license = licenses.mit;
    };
  };

  cpr = stdenv.mkDerivation rec {
    name = "cpr";
    version = "1.6.0";
    src = fetchFromGitHub {
      owner = "libcpr";
      repo = name;
      rev = "refs/tags/${version}";
      hash = "sha256-Y2jCINX4Gb5bKLCibYmtDllk1HrxwZE62BBHABK4TX0=";
    };
    nativeBuildInputs = [ cmake ];
    buildInputs = [ openssl ];
    propagatedBuildInputs = [ curl ];
    cmakeFlags = [ "-DCPR_FORCE_USE_SYSTEM_CURL=ON" "-DCPR_BUILD_TESTS=OFF" ];
    meta = with lib; {
      homepage = "https://github.com/libcpr/cpr";
      description = "C++ Requests: Curl for People, a spiritual port of Python Requests";
      license = licenses.mit;
    };
  };
in
stdenv.mkDerivation {
  name = "libkazv";
  version = "unstable";

  src = fetchFromGitLab {
    domain = "lily-is.land";
    owner = "kazv";
    repo = "libkazv";
    rev = "036300edd2494ec051ec6c71d154ccbb171ae10c";
    hash = "sha256-aISYVpGuj2l3x6BF0iB12fXd/fMsDFBfsIZ+0FNA+7Q=";
  };

  nativeBuildInputs = [ cmake pkg-config ];

  propagatedBuildInputs = [
    lager
    immer
    zug
    boost
    nlohmann_json
    olm
    cryptopp

    cpr

    catch2_3
  ];

  cmakeFlags = [
    "-Dlibkazv_BUILD_KAZVJOB=ON"
    "-Dlibkazv_INSTALL_HEADERS=ON"
    "-Dlibkazv_BUILD_EXAMPLES=OFF"
    "-Dlibkazv_BUILD_TESTS=ON"
  ];

  meta = with lib; {
    description = "A sans-io C++ (gnu++17) matrix client library";
    homepage = "https://lily-is.land/kazv/libkazv";
    license = licenses.agpl3Plus;
    maintainers = with maintainers; [ xyenon ];
  };
}
