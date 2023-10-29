{
  config,
  lib,
  pkgs,
  ...
}:
lib.vim.mkSimplePlugin {
  inherit config;
  plugin = pkgs.fetchFromGitHub {
    owner = "mfussenegger";
    repo = "nvim-dap";
    rev = "92dc531eea2c9a3ef504a5c8ac0decd1fa59a6a3";
    sha256 = "sha256-25n3gNbuhF+CaBRcbcWzhFkvF1HRCns1GEYGF0lSmp4=";
  };
  category = ["lsp"];
  noSetup = true;
  extraPluginConfig = _: {
    dependencies = [
      {
        src = pkgs.fetchFromGitHub {
          owner = "rcarriga";
          repo = "nvim-dap-ui";
          rev = "34160a7ce6072ef332f350ae1d4a6a501daf0159";
          sha256 = "sha256-IdWPzLpNH0fkubELr2uTI7UnB0Yaf/zCkF8WUWBtyaM=";
        };
        config =
          lib.lua.rawLua
          /*
          lua
          */
          ''
            function()
              local dap = require('dap')
              local dapui = require('dapui')
              dapui.setup()
              dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
              end
              dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
              end
              dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
              end
            end
          '';
      }
    ];
  };
}
