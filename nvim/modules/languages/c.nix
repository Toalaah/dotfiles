{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.languages.c;
in {
  options = {
    languages.c = {
      enable = mkEnableOption (lib.mdDoc "c");
      lspPkg = mkOption {
        type = types.package;
        default = pkgs.clang-tools;
        description = lib.mdDoc "clangd language server package to use";
      };
      settings = mkOption {
        type = types.attrs;
        default = {};
        description = lib.mdDoc ''
          server-configuration settings to pass to the lsp-config setup.
        '';
      };
    };
  };
  config = mkMerge [
    (mkIf cfg.enable {
      treesitter.parsers = ["c"];

      lsp.lsp-config.servers.clangd = {
        cmd = ["${cfg.lspPkg}/bin/clangd"];
        extraOpts = {
          inherit (cfg) settings;
        };
      };
    })
  ];
}
