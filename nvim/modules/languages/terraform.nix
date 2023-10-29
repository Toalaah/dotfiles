{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.languages.terraform;
in {
  options = {
    languages.terraform = {
      enable = mkEnableOption (lib.mdDoc "terraform-ls");
      lspPkg = mkOption {
        type = types.package;
        default = pkgs.terraform-ls;
        description = lib.mdDoc "terraform language server package to use";
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
      treesitter.parsers = ["terraform"];

      lsp.lsp-config.servers.terraform_lsp = {
        cmd = ["${cfg.lspPkg}/bin/terraform-ls" "serve"];
        extraOpts = {
          inherit (cfg) settings;
        };
      };
    })
  ];
}
