{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.modules.editor.emacs;
in {
 options.modules.editor.emacs.enable = mkEnableOption "emacs";

  config = mkIf cfg.enable {

  services.emacs.package = pkgs.emacsPgtkNativeComp;

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
      sha256 = "sha256:0ns8gx7ahajczlv36bq3d1dadinjq3fppfzfx4hc03v3hiaf30lx";
    }))
  ];


    environment.systemPackages = with pkgs; [
      emacsPgtkNativeComp
    ];

    services.emacs.enable = true;
  };
}
