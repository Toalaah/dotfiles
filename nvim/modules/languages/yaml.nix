{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.languages.yaml;
  hasSchemasStore = config.tools.schemastore.enable or false;
in {
  options = {
    languages.yaml = {
      enable = mkEnableOption (lib.mdDoc "yamlls");
      lspPkg = mkOption {
        type = types.package;
        default = pkgs.yaml-language-server;
        description = lib.mdDoc "yaml language server package to use";
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
    (mkIf hasSchemasStore {
      languages.yaml.settings.yaml = {
        schemaStore = {
          enable = false;
          url = "";
        };
        schemas = lib.lua.rawLua "require('schemastore').yaml.schemas()";
      };
    })
    (mkIf cfg.enable {
      treesitter.parsers = ["yaml"];

      lsp.lsp-config.servers.yamlls = {
        cmd = ["${cfg.lspPkg}/bin/yaml-language-server" "--stdio"];
        extraOpts = {inherit (cfg) settings;};
      };
    })
  ];
}
