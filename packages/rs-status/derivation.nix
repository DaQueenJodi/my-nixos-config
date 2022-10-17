{ lib, rustPlatform, fetchFromGitHub, pkg-config, libX11, libXcursor
, libxcb }:

rustPlatform.buildRustPackage rec {
  pname = "rs-status";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "DaQueenJodi";
    repo = pname;
    rev = version;
    hash = "";
  };

  cargoSha256 = "";

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ libX11 libXcursor libxcb ];

  # meta is optional, only needed when you want to PR it to nixpkgs
  meta = with lib; {
    description = "dwm status bar made in rust";
    homepage = "https://github.com/DaQueenJodi/rs-status";
    maintainers = with lib.maintainers; [ ];
    license = licenses.yourLicense;
  };
}
