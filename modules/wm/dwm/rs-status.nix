{ lib, rustPlatform, fetchFromGitHub, pkg-config, libX11, libXcursor
, libxcb }:

rustPlatform.buildRustPackage rec {
  pname = "rs-status";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "DaQueenJodi";
    repo = pname;
    rev = "848fbad";
    hash = "sha256-vJRuE5nI76/gAD/vslGgsT3RuJ+Xe5JtUhO2EyCYfe8=";
  };

  cargoSha256 = "sha256-ycKUAK17qCtLuvna0MiK7Iqm91VINj5MKuDq8XXj/gQ=";

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ libX11 libXcursor libxcb ];

}
