{ lib, rustPlatform, fetchFromGitHub, pkg-config, libX11, libXcursor
, libxcb }:

rustPlatform.buildRustPackage rec {
  pname = "rs-status";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "DaQueenJodi";
    repo = pname;
    rev = "b94b143";
    hash = "";
  };

  cargoSha256 = "";

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ libX11 libXcursor libxcb ];

}
