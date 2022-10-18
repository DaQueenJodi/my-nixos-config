{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.modules.editor.emacs;
in {
 options.modules.editor.emacs = mkEnableOption "emacs";

  config = mkIf cfg.enable {

  services.emacs.package = pkgs.emacsPgtkGcc;

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
      sha256 = "";
    }))
  ];


    environment.systemPackages = with pkgs; [
      emacsPgtkGcc
    ];

    services.emacs.enable = true;
  };
}
