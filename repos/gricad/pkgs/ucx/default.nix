{ lib, stdenv, fetchFromGitHub, fetchpatch, autoreconfHook, doxygen
, numactl, rdma-core, libbfd, libiberty, perl, zlib, symlinkJoin
, pkgconfig
, enableCuda ? false
, enableRocm ? false
, cudatoolkit
, rocm-core, rocm-runtime, rocm-device-libs, hip
}:

let
  # Needed for configure to find all libraries
  cudatoolkit' = symlinkJoin {
    inherit (cudatoolkit) name meta;
    paths = [ cudatoolkit cudatoolkit.lib ];
  };
  rocm = symlinkJoin {
    name = "rocm";
    paths = [ rocm-core rocm-runtime rocm-device-libs hip ];
  };

in stdenv.mkDerivation rec {
  pname = "ucx";
  version = "1.14.0";

  src = fetchFromGitHub {
    owner = "openucx";
    repo = "ucx";
    rev = "v${version}";
    sha256 = "sha256-OSYeJfMi57KABt8l3Yj0glqx54C5cwM2FqlijszJIk4=";
  };

  nativeBuildInputs = [ autoreconfHook doxygen pkgconfig ];

  buildInputs = [
    libbfd
    libiberty
    numactl
    perl
    rdma-core
    zlib
  ] ++ lib.optional enableCuda cudatoolkit
    ++ lib.optional enableRocm [ rocm-core rocm-runtime rocm-device-libs hip ];

  configureFlags = [
    "--with-rdmacm=${rdma-core}"
    "--with-dc"
    "--with-rc"
    "--with-dm"
    "--with-verbs=${rdma-core}"
  ] ++ lib.optional enableCuda "--with-cuda=${cudatoolkit'}"
    ++ lib.optional enableRocm "--with-rocm=${rocm}";

  enableParallelBuilding = true;

  meta = with lib; {
    description = "Unified Communication X library";
    homepage = "https://www.openucx.org";
    license = licenses.bsd3;
    platforms = platforms.linux;
    maintainers = [ maintainers.markuskowa ];
  };
}
