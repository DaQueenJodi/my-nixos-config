{
  config,
  lib,
  pkgs,
  dwl,
  ...
}:
with lib; let
  cfg = config.modules.wm.dwl;
in {
  options.modules.wm.dwl.enable = mkEnableOption "dwl";

  config = mkMerge [
    {
      users.users.jodi.packages = with pkgs; [
        (pkgs.callPackage ./somebar.nix{})
        (pkgs.callPackage ../dwm/rs-status.nix{})
        wl-clipboard
        fuzzel # app launcher
      ];
    }
    (mkIf cfg.enable {
      services.xserver.displayManager.startx.enable = true; # disable display manager
      services.xserver.windowManager.session = optionals cfg.enable [
        {
          name = "dwl";
          manage = "window";
          start = ''
            ~/.on_start_dwl &
            dwl &
            waitPID=$!
          '';
        }
      ];

      users.users.jodi.packages = [dwl];
    })
  ];
}
