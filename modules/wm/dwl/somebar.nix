{ stdenv, pkgs}:

stdenv.mkDerivation rec {
  pname = "somebar";
  version = "1.0";
  src = pkgs.fetchFromSourceHut {
    owner = "~raphi";
    repo = "somebar";
    rev = "${version}"
    sha256 = "";
  };

  buildInputs = with pkgs; [
    meson
    ninja
  ];

  configurationPhase = ''
  cp src/config.def.hpp src/config.hpp
  meson --prefix $out setup build
'';

  installPhase = ''
  mkdir -p $out/bin
  ninja -C build
  ninja -C build install
'';
  
}
