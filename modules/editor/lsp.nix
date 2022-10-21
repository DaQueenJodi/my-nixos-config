{
  lib,
  pkgs,
  config,
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
      nil
      rust-analyzer
      # FORMATTERS
      luaformatter
      rustfmt
    ];
  };
}
