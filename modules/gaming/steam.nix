{
  config,
  lib,
  pkgs,
}:
with lib; let
  cfg = config.modules.gaming.steam;
in {
  options.modules.gaming.steam = mkEnableOption "steam";

  config = mkMerge [
    (mkIf cfg.enable {
      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
      }
      environment.sessionVariables = rec {
        STEAM_EXTRA_COMPAT_TOOL_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
      };
      environment.variables.STEAMOS = mkOverride 900 "anything";
      };
    };
  ];
}
