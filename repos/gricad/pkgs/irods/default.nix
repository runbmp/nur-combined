{ stdenv, fetchFromGitHub, bzip2, zlib, autoconf, automake, cmake, gnumake, help2man , texinfo, libtool , cppzmq , libarchive, avro-cpp_llvm, boost, jansson, zeromq, openssl , pam, libiodbc, kerberos, gcc, libcxx, which }:

with stdenv;

let
  avro-cpp=avro-cpp_llvm;
in
let
  common = import ./common.nix {
    inherit stdenv bzip2 zlib autoconf automake cmake gnumake
            help2man texinfo libtool cppzmq libarchive jansson
            zeromq openssl pam libiodbc kerberos gcc libcxx
            boost avro-cpp which;
  };
in rec {

  # irods: libs and server package
  irods = stdenv.mkDerivation (common // rec {
    version = "4.2.7";
    pname = "irods";

    src = fetchFromGitHub {
      owner = "irods";
      repo = "irods";
      rev = version;
      sha256 = "06im1rkidz8mynpwgry8d97g4zfx95sfw5y9vf82c1zch5rih6n4";
    };

    # Patches:
    # irods_root_path.patch : the root path is obtained by stripping 3 items of the path,
    #                         but we don't use /usr with nix, so remove only 2 items.
    patches = [ ./irods_root_path.patch ];

    # fix build with recent llvm versions
    NIX_CFLAGS_COMPILE = "-Wno-deprecated-register -Wno-deprecated-declarations";

    preConfigure = common.preConfigure + ''
      patchShebangs ./test
      substituteInPlace plugins/database/CMakeLists.txt --replace "COMMAND cpp" "COMMAND ${gcc.cc}/bin/cpp"
      substituteInPlace cmake/server.cmake --replace "DESTINATION usr/sbin" "DESTINATION sbin"
      substituteInPlace cmake/server.cmake --replace "IRODS_DOC_DIR usr/share" "IRODS_DOC_DIR share"
      substituteInPlace cmake/runtime_library.cmake --replace "DESTINATION usr/lib" "DESTINATION lib"
      substituteInPlace cmake/development_library.cmake --replace "DESTINATION usr/lib" "DESTINATION lib"
      substituteInPlace cmake/development_library.cmake --replace "DESTINATION usr/include" "DESTINATION include"
      export cmakeFlags="$cmakeFlags
        -DCMAKE_EXE_LINKER_FLAGS=-Wl,-rpath,$out/lib
        -DCMAKE_MODULE_LINKER_FLAGS=-Wl,-rpath,$out/lib
        -DCMAKE_SHARED_LINKER_FLAGS=-Wl,-rpath,$out/lib
        "

      substituteInPlace cmake/server.cmake --replace SETUID ""
    '';

    meta = common.meta // {
      longDescription = common.meta.longDescription + ''
        This package provides the servers and libraries.'';
    };
  });


  # icommands (CLI) package, depends on the irods package
  irods-icommands = stdenv.mkDerivation (common // rec {
     version = "4.2.7";
     pname = "irods-icommands";

     src = fetchFromGitHub {
       owner = "irods";
       repo = "irods_client_icommands";
       rev = version;
       sha256 = "1lkbnc76w4fx6xq4kns3f7rgiw8c7x6d2kp0h2fqfqzpn211qz4c";
     };

     patches = [ ./zmqcpp-deprecated-send_recv.patch ];

     buildInputs = common.buildInputs ++ [ irods ];

     preConfigure = common.preConfigure + ''
       patchShebangs ./bin
     '';

     cmakeFlags = common.cmakeFlags ++ [
       "-DCMAKE_INSTALL_PREFIX=${out}"
       "-DIRODS_DIR=${irods}/lib/irods/cmake"
       "-DCMAKE_EXE_LINKER_FLAGS=-Wl,-rpath,${irods}/lib"
       "-DCMAKE_MODULE_LINKER_FLAGS=-Wl,-rpath,${irods}/lib"
       "-DCMAKE_SHARED_LINKER_FLAGS=-Wl,-rpath,${irods}/lib"
    ];

     meta = common.meta // {
       description = common.meta.description + " CLI clients";
       longDescription = common.meta.longDescription + ''
         This package provides the CLI clients, called 'icommands'.'';
       broken = true;
     };
  });
}

