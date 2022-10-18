{ lib, rustPlatform, fetchFromGitHub, pkg-config, libX11, libXcursor
, libxcb }:

rustPlatform.buildRustPackage rec {
  pname = "rs-status";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "DaQueenJodi";
    repo = pname;
    rev = "b94b143";
    hash = "sha256-lBZo8g4WoDGwXOh+9vSrnxQqXSJ5rG/2+YyyPpOJGOg=";
  };

  cargoSha256 = "sha256-ycKUAK17qCtLuvna0MiK7Iqm91VINj5MKuDq8XXj/gQ=";

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ libX11 libXcursor libxcb ];

}
