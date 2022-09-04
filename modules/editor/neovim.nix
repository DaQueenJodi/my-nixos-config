  {
    lib,
    pkgs,
    config,
    ...
  }:
  with lib; let
    cfg = config.modules.editor.neovim;
  in {
    options.modules.editor.neovim.enable = mkEnableOption "neovim";

    config = mkIf cfg.enable {
      environment.systemPackages =  with pkgs; [
          neovim
          nodejs
          clang-tools
        ];
    # make neovim the default editor
    environment.variables.EDITOR = mkOverride 900 "nvim";
    };
  }

