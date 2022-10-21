{
  config,
  lib,
  pkgs,
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
        wl-clipboard
        slurp
        grim
      ];
    }
    (mkIf cfg.enable {
      services.xserver.windowManager.session = optionals cfg.enable [
        {
          name = "dwl";
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
