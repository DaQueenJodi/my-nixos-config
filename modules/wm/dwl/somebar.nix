{ stdenv, pkgs}:
stdenv.mkDerivation rec {
  pname = "somebar";
  version = "1.0.0";
  src = pkgs.fetchFromSourcehut {
    owner = "~raphi";
    repo = "somebar";
    rev = "${version}";
    sha256 = "sha256-snCW7dC8JI/pg1+HLjX0JXsTzwa3akA6rLcSNgKLF0c=";
  };


  nativeBuildInputs = with pkgs; [
    meson
    ninja
    pkg-config
  ];
  
  buildInputs = with pkgs; [
    cmake
    wayland-protocols
    wayland
    wlroots
    cairo
    pango
  ];

  prePatch = ''
  cp src/config.def.hpp src/config.hpp
'';
}
