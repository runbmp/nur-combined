{ stdenv, fetchFromGitHub, cmake }:

stdenv.mkDerivation rec {
  pname = "powercap";
  version = "0.2.0";
  
  src = fetchFromGitHub {
    owner = "powercap";
    repo = "powercap";
    rev = "ad05da76ca84d3c5277d932a32d15fd7c709aa7d";
    sha256 = "1xpik0wrg0gk4s03wfjr5sc6p410dpddg9iyrsdgg2lia55d0ajd";
  };

  buildInputs = [ cmake ];

  meta = with stdenv.lib; {
    homepage = "https://github.com/powercap/powercap";
    description = "C bindings to the Linux Power Capping Framework in sysfs ";
    license = licenses.bsd3;
    platforms = platforms.linux;
  };
}
