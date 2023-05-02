# This file was generated by nvfetcher, please do not modify it manually.
{
  fetchgit,
  fetchurl,
  fetchFromGitHub,
  dockerTools,
}: {
  basiliskii-bin = {
    pname = "basiliskii-bin";
    version = "2023-04-11";
    src = fetchurl {
      url = "https://github.com/Korkman/macemu-appimage-builder/releases/download/2023-04-11/BasiliskII-x86_64.AppImage";
      sha256 = "sha256-PEJ4HHGRO8+BuOYaR3jIRn7+TlHqxyqkegHL7w5eLU8=";
    };
  };
  bling = {
    pname = "bling";
    version = "677917056d118d02feaa5c21ecf5a50375ef123d";
    src = fetchFromGitHub {
      owner = "blingcorp";
      repo = "bling";
      rev = "677917056d118d02feaa5c21ecf5a50375ef123d";
      fetchSubmodules = false;
      sha256 = "sha256-V3ZAWhDH2b1n3G3ZMpH1k9yZFQm1wsAfAX4+eKciOKk=";
    };
    date = "2023-03-07";
  };
  cardinal = {
    pname = "cardinal";
    version = "5307b9f540cb257b63ea56de080e302420929f51";
    src = fetchFromGitHub {
      owner = "DISTRHO";
      repo = "Cardinal";
      rev = "5307b9f540cb257b63ea56de080e302420929f51";
      fetchSubmodules = true;
      sha256 = "sha256-tdi6mAIzZu7Ylu+TTDFMtjCWRP8Pht837LdvJSo7+ww=";
    };
    date = "2023-04-25";
  };
  carla = {
    pname = "carla";
    version = "96b67721b68585e3980a32b3e558160d59305050";
    src = fetchFromGitHub {
      owner = "falkTX";
      repo = "Carla";
      rev = "96b67721b68585e3980a32b3e558160d59305050";
      fetchSubmodules = false;
      sha256 = "sha256-v+z+tz0lyAvK1u8SJVazav9KbxpWxLfJ3uv0o54q+s0=";
    };
    date = "2023-05-02";
  };
  dmenu-flexipatch = {
    pname = "dmenu-flexipatch";
    version = "fc8c1c56c6548660e3b32a18327ca8f0d98e8e33";
    src = fetchFromGitHub {
      owner = "bakkeby";
      repo = "dmenu-flexipatch";
      rev = "fc8c1c56c6548660e3b32a18327ca8f0d98e8e33";
      fetchSubmodules = false;
      sha256 = "sha256-hoROVS3unzHP6DY0N2KMsnF05rVqWUi19dvaqNACexs=";
    };
    date = "2023-04-21";
  };
  dpf-plugins = {
    pname = "dpf-plugins";
    version = "v1.7";
    src = fetchFromGitHub {
      owner = "DISTRHO";
      repo = "DPF-Plugins";
      rev = "v1.7";
      fetchSubmodules = false;
      sha256 = "sha256-768DlGZrD2vNoHAuVh3SxQHCIT4l44qORGWajo4bTiA=";
    };
  };
  dwm-flexipatch = {
    pname = "dwm-flexipatch";
    version = "5fefbfee64fc0fa1ebe49f92979157ffa2c7c1ae";
    src = fetchFromGitHub {
      owner = "bakkeby";
      repo = "dwm-flexipatch";
      rev = "5fefbfee64fc0fa1ebe49f92979157ffa2c7c1ae";
      fetchSubmodules = false;
      sha256 = "sha256-DLalFR7yC/O6icV3jLu37n6agIkl5/W+ESPvfRkrLgE=";
    };
    date = "2023-04-09";
  };
  fennel-language-server = {
    pname = "fennel-language-server";
    version = "d0c65db2ef43fd56390db14c422983040b41dd9c";
    src = fetchFromGitHub {
      owner = "rydesun";
      repo = "fennel-language-server";
      rev = "d0c65db2ef43fd56390db14c422983040b41dd9c";
      fetchSubmodules = false;
      sha256 = "sha256-KU2MPmgHOS/WesBzCmEoHHXHoDWCyqjy49tmMmZw5BQ=";
    };
    cargoLock."Cargo.lock" = {
      lockFile = ./fennel-language-server-d0c65db2ef43fd56390db14c422983040b41dd9c/Cargo.lock;
      outputHashes = {
      };
    };
    date = "2023-03-01";
  };
  ildaeil = {
    pname = "ildaeil";
    version = "f604cca23e3e15e40ed5b25333db25350c3bc67e";
    src = fetchFromGitHub {
      owner = "DISTRHO";
      repo = "Ildaeil";
      rev = "f604cca23e3e15e40ed5b25333db25350c3bc67e";
      fetchSubmodules = true;
      sha256 = "sha256-3havCjlh46bKzM7iFtBF4oSlqvru07JgbMpVKtnZEZM=";
    };
    date = "2023-04-23";
  };
  keepmenu = {
    pname = "keepmenu";
    version = "1.3.1";
    src = fetchFromGitHub {
      owner = "firecat53";
      repo = "keepmenu";
      rev = "1.3.1";
      fetchSubmodules = false;
      sha256 = "sha256-1s+vl5j0oPERUvJCKFTvLubCF8Nhx7OtkPjpWmpEG/o=";
    };
  };
  kiwmi = {
    pname = "kiwmi";
    version = "17814972abe6a8811a586fa87c99a2b16a86075f";
    src = fetchFromGitHub {
      owner = "buffet";
      repo = "kiwmi";
      rev = "17814972abe6a8811a586fa87c99a2b16a86075f";
      fetchSubmodules = false;
      sha256 = "sha256-n9PA6cyEjSlnDcRrqIkO83UaCE/hovbi/oZon1B+nuw=";
    };
    date = "2022-07-30";
  };
  kmonad = {
    pname = "kmonad";
    version = "3aa2f52536de853efbcb0f6e790c97a3734687ec";
    src = fetchFromGitHub {
      owner = "kmonad";
      repo = "kmonad";
      rev = "3aa2f52536de853efbcb0f6e790c97a3734687ec";
      fetchSubmodules = false;
      sha256 = "sha256-gFiQ62jbBfumg0IR4oXR/DRVunOxMd4lJ5+g+qjz7wA=";
    };
    date = "2023-04-26";
  };
  lua-dbus = {
    pname = "lua-dbus";
    version = "cdef26d09aa61d7f1f175675040383f6ae0becbb";
    src = fetchFromGitHub {
      owner = "dodo";
      repo = "lua-dbus";
      rev = "cdef26d09aa61d7f1f175675040383f6ae0becbb";
      fetchSubmodules = false;
      sha256 = "sha256-S+W6QTqv4kdyR86GCyDLnkml10dO4ZVNXEd3/7vDFGE=";
    };
    date = "2015-04-22";
  };
  lua-dbus_proxy = {
    pname = "lua-dbus_proxy";
    version = "v0.10.3";
    src = fetchFromGitHub {
      owner = "stefano-m";
      repo = "lua-dbus_proxy";
      rev = "v0.10.3";
      fetchSubmodules = false;
      sha256 = "sha256-Yd8TN/vKiqX7NOZyy8OwOnreWS5gdyVMTAjFqoAuces=";
    };
  };
  luakit = {
    pname = "luakit";
    version = "858dc946b01487e6ba2475cb7a9bede34c17d134";
    src = fetchFromGitHub {
      owner = "luakit";
      repo = "luakit";
      rev = "858dc946b01487e6ba2475cb7a9bede34c17d134";
      fetchSubmodules = false;
      sha256 = "sha256-TKQvnavoofGtBo2aBJtZVZjrmm5Ln7vOgW9bAXjcpRM=";
    };
    date = "2023-01-29";
  };
  lv2vst = {
    pname = "lv2vst";
    version = "30a669a021812da05258519cef9d4202f5ce26c3";
    src = fetchFromGitHub {
      owner = "x42";
      repo = "lv2vst";
      rev = "30a669a021812da05258519cef9d4202f5ce26c3";
      fetchSubmodules = false;
      sha256 = "sha256-WFVscNivFrsADl7w5pSYx9g+UzK2XUBF7x0Iqg8WKiQ=";
    };
    date = "2020-06-07";
  };
  macemu = {
    pname = "macemu";
    version = "ef3f61c30d7febbb604554335a4ea7721734e3e3";
    src = fetchFromGitHub {
      owner = "kanjitalk755";
      repo = "macemu";
      rev = "ef3f61c30d7febbb604554335a4ea7721734e3e3";
      fetchSubmodules = false;
      sha256 = "sha256-RVdQtT02AeGa70kWIQ5zIDEFX1T/cafAcdyy4l1cUIQ=";
    };
    date = "2023-04-04";
  };
  raze = {
    pname = "raze";
    version = "1.7.1";
    src = fetchFromGitHub {
      owner = "ZDoom";
      repo = "Raze";
      rev = "1.7.1";
      fetchSubmodules = false;
      sha256 = "sha256-8e8F18kYLmEvQF0ZSpgih8hMYfcaZ0otrh26rkju9b4=";
    };
  };
  sheepshaver-bin = {
    pname = "sheepshaver-bin";
    version = "2023-04-11";
    src = fetchurl {
      url = "https://github.com/Korkman/macemu-appimage-builder/releases/download/2023-04-11/SheepShaver-x86_64.AppImage";
      sha256 = "sha256-YwCKFY7OAuM6L0DU/fr/0G6QDUKlVutpSB1daCstvgc=";
    };
  };
  slock-flexipatch = {
    pname = "slock-flexipatch";
    version = "780a7887a3b976a48786f991d55fc8a474e76a25";
    src = fetchFromGitHub {
      owner = "bakkeby";
      repo = "slock-flexipatch";
      rev = "780a7887a3b976a48786f991d55fc8a474e76a25";
      fetchSubmodules = false;
      sha256 = "sha256-3jzEXIaH6qZkbvumlYqPSW1kDjg8obDMVoj6y3Vhe4I=";
    };
    date = "2022-10-06";
  };
  st-flexipatch = {
    pname = "st-flexipatch";
    version = "1343b29ee5e8a9d67607a4616f74386a2951e276";
    src = fetchFromGitHub {
      owner = "bakkeby";
      repo = "st-flexipatch";
      rev = "1343b29ee5e8a9d67607a4616f74386a2951e276";
      fetchSubmodules = false;
      sha256 = "sha256-cZcoBkgcG+MXVSmjupdmhEQv7j54rANbmMso6XnatEw=";
    };
    date = "2023-04-07";
  };
  taffybar = {
    pname = "taffybar";
    version = "5d1685f87ecbf283119110d002813d82f74342ea";
    src = fetchFromGitHub {
      owner = "taffybar";
      repo = "taffybar";
      rev = "5d1685f87ecbf283119110d002813d82f74342ea";
      fetchSubmodules = false;
      sha256 = "sha256-etRsa9KqU4xNLJ6DYWh6/vKtc9tAX7yGpQbc0SROeo8=";
    };
    date = "2023-03-11";
  };
  tailwindcss-intellisense = {
    pname = "tailwindcss-intellisense";
    version = "ae99cbfafc0ddeaecd16edd519ab48cf306190c0";
    src = fetchFromGitHub {
      owner = "tailwindlabs";
      repo = "tailwindcss-intellisense";
      rev = "ae99cbfafc0ddeaecd16edd519ab48cf306190c0";
      fetchSubmodules = false;
      sha256 = "sha256-HWIBOFENkvdmfYmbeqluTaSO3J1Qs3VyxmB4GHAOn2c=";
    };
    date = "2023-04-28";
  };
  xmonad-entryhelper = {
    pname = "xmonad-entryhelper";
    version = "ee2d0c14f9258503d7bd62907aa731dd64fa34d0";
    src = fetchFromGitHub {
      owner = "Javran";
      repo = "xmonad-entryhelper";
      rev = "ee2d0c14f9258503d7bd62907aa731dd64fa34d0";
      fetchSubmodules = false;
      sha256 = "sha256-CGaibR0Yejng9IQInm92Zx0pEZS29tJjWvPgaiWgUNQ=";
    };
    date = "2022-05-18";
  };
  zix = {
    pname = "zix";
    version = "b4ef50c50590c273984d27f9c3a311e7ee8c0ce4";
    src = fetchFromGitHub {
      owner = "drobilla";
      repo = "zix";
      rev = "b4ef50c50590c273984d27f9c3a311e7ee8c0ce4";
      fetchSubmodules = false;
      sha256 = "sha256-tJPOI2X/Ak6aJTmsQmWrf1eAOmuxaJZ1U85PlLYR7XM=";
    };
    date = "2023-05-01";
  };
  zmusic = {
    pname = "zmusic";
    version = "1.1.3";
    src = fetchFromGitHub {
      owner = "ZDoom";
      repo = "ZMusic";
      rev = "1.1.3";
      fetchSubmodules = false;
      sha256 = "sha256-wrNWfTIbNU/S2qFObUSkb6qyaceh+Y7Loxqudl86+W4=";
    };
  };
  zrythm = {
    pname = "zrythm";
    version = "6232465311f7478f34637af4f9f6085f992b6095";
    src = fetchgit {
      url = "https://git.sr.ht/~alextee/zrythm";
      rev = "6232465311f7478f34637af4f9f6085f992b6095";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-pIaWjFsfbiUb/iV+sonLpnXj8zCbTXcYE9Ewz8NcpRI=";
    };
    date = "2023-05-01";
  };
}
