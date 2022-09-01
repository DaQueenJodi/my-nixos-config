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
      users.users.jodi.packages = with pkgs; [
        maim
        xclip
      ];
    }
    (mkIf cfg.enable {
      services.xserver.windowManager.session = optionals cfg.enable [
        {
          name = "dwm";
          start = ''
            dwm &
            waitPID=$!
          '';
        }
      ];

      users.users.jodi.packages = [dwm];
    })
  ];
}