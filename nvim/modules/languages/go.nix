{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.languages.go;
in {
  options = {
    languages.go = {
      enable = mkEnableOption (lib.mdDoc "go");
      lspPkg = mkOption {
        type = types.package;
        default = pkgs.gopls;
        description = lib.mdDoc "go language server package to use";
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
      treesitter.parsers = ["go"];

      extraPackages = [pkgs.go];

      lsp.lsp-config.servers.gopls = {
        cmd = ["${cfg.lspPkg}/bin/gopls" "serve"];
        extraOpts = {
          inherit (cfg) settings;
        };
      };
    })
  ];
}
