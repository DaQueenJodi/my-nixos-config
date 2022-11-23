{
  config,
  lib,
  pkgs,
  dwm,
  ...
}:
with lib; let
  cfg = config.modules.wm.dwm;
in {
  options.modules.wm.dwm.enable = mkEnableOption "dwm";

  config = mkMerge [
    {
      environment.systemPackages = with pkgs; [
        (pkgs.callPackage ./rs-status.nix {})
        maim
        xclip
        rofi
        picom
        xfce.xfce4-clipman-plugin
        pamixer
      ];
    }
    (mkIf cfg.enable {
      services.xserver.windowManager.session = optionals cfg.enable [
        {
          name = "dwm";
          start = ''
            ~/.on_start_dwm &
            dwm &
            waitPID=$!
          '';
        }
      ];

      environment.systemPackages = [dwm];
    })
  ];
}
