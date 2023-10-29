{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.languages.java;
in {
  options = {
    languages.java = {
      enable = mkEnableOption (lib.mdDoc "jdtls");
      lspPkg = mkOption {
        type = types.package;
        default = pkgs.jdt-language-server;
        description = lib.mdDoc "jdtls package to use";
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
      treesitter.parsers = ["java"];
      extraPackages = [cfg.lspPkg];
      lsp.lsp-config.servers.jdtls = {
        cmd = ["${cfg.lspPkg}/bin/jdt-language-server" "-configuration" "/home/samuel/.cache/jdtls/config" "-data" "/home/samuel/.cache/jdtls/workspace"];
        extraOpts = {
          inherit (cfg) settings;
        };
      };
    })
  ];
}
