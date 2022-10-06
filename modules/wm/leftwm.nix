{
  config,
  lib,
  pkgs,
  leftwm,
  ...
}:
with lib; let
  cfg = config.modules.wm.leftwm;
in {
  options.modules.wm.leftwm.enable = mkEnableOption "leftwm";

  config = mkMerge [
    {
      users.users.jodi.packages = with pkgs; [
        maim
        xclip
        trayer
        xfce.xfce4-clipman-plugin
      ];
    }
    (mkIf cfg.enable {
      services.xserver.windowManager.session = optionals cfg.enable [
        {
          name = "leftwm";
          start = ''
            ~/.on_start_leftwm &
            leftwm &
            waitPID=$!
          '';
        }
      ];

      users.users.jodi.packages = [leftwm];
    })
  ];
}
