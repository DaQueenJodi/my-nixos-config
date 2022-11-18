{pkgs, ...}: {
  imports = [
    ./dwm
    ./dwl
    ./awesome.nix
    ./leftwm.nix
  ];
}
