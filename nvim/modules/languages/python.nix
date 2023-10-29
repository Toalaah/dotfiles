{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.languages.python;
  py = pkgs.python3.withPackages (ps: [ps.debugpy]);
  dap-venv = "${py}/bin/python3";
in {
  options = {
    languages.python = {
      enable = mkEnableOption (lib.mdDoc "python lsp capabilities");
      lspPkg = mkOption {
        type = types.package;
        default = pkgs.pyright;
        description = lib.mdDoc "python language server package to use";
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
      treesitter.parsers = ["python"];
      extraPackages = [pkgs.python3Packages.debugpy];

      lsp.lsp-config.servers.pyright = {
        cmd = ["${cfg.lspPkg}/bin/pyright-langserver" "--stdio"];
        extraOpts = {
          inherit (cfg) settings;
        };
      };

      plugins = [
        {
          src = pkgs.fetchFromGitHub {
            owner = "mfussenegger";
            repo = "nvim-dap-python";
            rev = "37b4cba02e337a95cb62ad1609b3d1dccb2e5d42";
            sha256 = "sha256-wT1OLg4gpKaeqcrSgef/aKmB3+IFPB5fF0OOUtVuyqA=";
          };
          ft = "python";
          dependencies = ["mfussenegger/nvim-dap"];
          config =
            lib.lua.rawLua
            /*
            lua
            */
            ''
              function(_, opts)
                require('dap-python').setup('${dap-venv}', opts)
              end
            '';
          opts.adapter_python_path = "${dap-venv}";
        }
      ];
    })
  ];
}
