{pkgs, ...}: {
  imports = [
    ./neovim
    ./emacs.nix
    ./lsp.nix
  ];
}
