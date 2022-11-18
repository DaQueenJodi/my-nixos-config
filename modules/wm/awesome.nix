{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.wm.awesomewm;

in {
  options.modules.wm.awesomewm.enable = mkEnableOption "awesomewm";

  config = mkMerge [
    {
      users.users.jodi.packages = with pkg; [
        maim
        xclip
        xfce4.xfce4-clipman-plugin
        picom
        polybar
      ];
    }
    (mkIf cfg.enable {
      windowManager.awesome = {
        enable = true;
        luaModules = with pkgs.luaPackages;
          [
            luarocks # package manager
          ];
      };
    })
  ];
}
