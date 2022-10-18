{pkgs, ...}: {
  imports = [
    ./neovim
    ./emacs.nix
  ];
}
