{
  lib,
  pkgs,
  config,
  pkgs-unstable,
  ...
}:
with lib; let
  cfg = config.modules.editor.lsp;
in {
  options.modules.editor.lsp.enable = mkEnableOption "lsp";
  
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # LSP
      clang-tools
      sumneko-lua-language-server
      rust-analyzer
      pkgs-unstable.nil
      # FORMATTERS
      nixfmt
      luaformatter
      rustfmt
    ];
    };
  }
