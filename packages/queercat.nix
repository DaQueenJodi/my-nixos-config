{ stdenv, pkgs }:

stdenv.mkDerivation rec {
  name = "queercat-${version}";
  version = "1.0";
  src = pkgs.fetchFromGitHub {
    repo = "queercat";
    owner = "Elsa002";
    rev = "725c61d";
    hash = "sha256-Q2++q2RanzkyyjBP1Mce6UCZEmMlumS7huuacptHTXA=";
  };
  buildPhase = "gcc main.c -lm -o queercat";
  installPhase = "install -Dm755 queercat $out";
}
