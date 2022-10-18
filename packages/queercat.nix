{ stdenv, pkgs }:

stdenv.mkDerivation rec {
  pname = "queercat";
  version = "1.0";
  src = pkgs.fetchFromGitHub {
    repo = "queercat";
    owner = "Elsa002";
    rev = "725c61d";
    hash = "sha256-Q2++q2RanzkyyjBP1Mce6UCZEmMlumS7huuacptHTXA=";
  };

  buildInputs = with pkgs; [
    cmake
  ];

  configurationPhase = ''
    cmake .
  '';

  installPhase = ''
    mkdir -p $out/bin 
    mv queercat $out/bin
    '';
  }
