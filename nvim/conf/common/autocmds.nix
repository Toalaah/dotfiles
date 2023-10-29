{lib, ...}: let
  inherit (lib.lua) rawLua;
  group = rawLua "user_custom_aucmds";
in {
  preHooks = ''
    local ${group null} = vim.api.nvim_create_augroup('${group null}', { clear = true })
  '';
  autocmds = [
    # {
    #   event = "FileType";
    #   pattern = "*";
    #   callback = rawLua "function() vim.cmd.checktime() end";
    #   description = "Reload file if it changed after regaining focus";
    #   inherit group;
    # }
    {
      event = "TextYankPost";
      pattern = "*";
      callback =
        rawLua
        /*
        lua
        */
        ''
          function()
            vim.highlight.on_yank { higroup = 'IncSearch'; timeout = 500 }
          end
        '';
      description = "Highlight copied content after yank";
      inherit group;
    }
    {
      event = "BufWritePre";
      pattern = "*";
      callback =
        rawLua
        /*
        lua
        */
        ''
          function(event)
            -- abort for "protocol" buffers (e.g. ssh://)
            if event.match:match('^%w+://') then
              return
            end
            local dir = vim.fn.expand('<afile>:p:h')
            if vim.fn.isdirectory(dir) == 0 then
              vim.fn.mkdir(dir, 'p')
            end
          end
        '';
      description = "Create directory if it doesn't exist on write";
      inherit group;
    }
  ];
}
