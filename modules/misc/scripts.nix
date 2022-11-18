{
  users,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.misc.scripts;
in {
  options.modules.misc.scripts.enable = mkEnableOption "scripts";

  config = mkMerge [
    (mkIf cfg.enable {
      users.users.jodi.packages = with pkgs; [ 
        (pkgs.writeShellScriptBin "screenshot" ''
          if [ "$1" = "select" ]; then
            MAIM_ARGS="--select"
          elif [ "$1" = "fullscreen" ]; then
            MAIM_ARGS="-i $(xdotool getactivewindow)"
          else
            echo "specify either 'select' or 'fullscreen'"
            exit 1
          fi
            maim --quality 10  $MAIM_ARGS | xclip -selection clipboard -t image/png
          '')
        # deps
        xdotool
        maim 
        xclip


        (pkgs.writeShellScriptBin "wlscreenshot" ''
            if [ "$1" = "select" ]; then
              grim -g "$(slurp -d)" - | wl-copy
            elif [ "$1" = "fullscreen" ]; then
              grim - | wl-copy
            fi                     
        '')
        grim
        slurp
        wl-clipboard
      ];
    }
    )
    ];
  }
