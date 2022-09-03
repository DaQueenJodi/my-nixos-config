  {
    lib,
    pkgs,
    config,
    ...
  }:
  with lib; let
    cfg = config.modules.editors.neovim;
  in {
    options.modules.editors.neovim.enable = mkEnableOption "neovim";

    config = mkMerge [
      {
        users.users.jodi.packages = with pkgs; [
          neovim
          nodejs
          clang-tools
        ];
      }
    ]
    # make neovim the default editor
    environment.variables.EDITOR = (mkOverride 900 "nvim");

  }

