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
    rev = "9d81c11fd185a131f81841e64941859305f6c42d";
    sha256 = "1pwn5c0hjm3wpzzybbakxgpq4bd7f6aygvslhivi4inzn48dla90";
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
          sha256 = "18y9dmh525jzj31gqzqs8q3jgd93jdmsy2xip7j4f7sdpb68zm91";
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
