{pkgs, ...}: {
  imports = [
    ./dwm
    ./dwl
    ./leftwm.nix
  ];
}
