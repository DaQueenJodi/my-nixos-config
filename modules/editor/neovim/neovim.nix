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
          ripgrep # for the telescope plugin
          fd # for the telescope plugin
          luaformatter # for formatting config
          sumneko-lua-language-server # for lsp support in configs
          nil # nixos lsp
        ];
    # make neovim the default editor
    environment.variables.EDITOR = mkOverride 900 "nvim";
    };
  }

