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
      users.users.jodi.packages = [ 
        (pkgs.writeShellScriptBin "screenshot" ''
            #!/bin/sh
            while getopts 'fs' OPTION; do
            case '$OPTION' in
              f)
                MAIM_ARGS="-i $(xdotool getactivewindow)"
                ;;
              s)
                MAIM_ARGS="--select"
                ;;
              ?)
                echo "usage: screenshot [-s] [-f]" >&2
                exit 1
                ;;
            esac
            done
            shift '$(($OPTIND -1))'
            maim --quality 10  $MAIM_ARGS | xclip -selection clipboard -t image/png
          '')
      ];
    }
    )
    ];
  }
