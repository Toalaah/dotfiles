---@param event string
---@param pattern string
---@param group string
---@param callback function|string
local function au_cmd(event, pattern, group, callback)
  vim.api.nvim_create_autocmd(event, {
    pattern = pattern,
    group = vim.api.nvim_create_augroup(group, { clear = true }),
    callback = callback,
  })
end

-- Set syntax of .env files to sh
au_cmd('BufEnter', '*.env*', '__env', function(args)
  vim.diagnostic.disable(args.buf)
  vim.bo.filetype = 'sh'
end)

-- Auto-sync / compile packer on changes to plugin file
au_cmd('BufWritePost', '*/plugins/init.lua', '__packer', function(_)
  require('lua.util').reload_module()
  vim.cmd([[PackerCompile]])
end)

-- Update xresources on write
au_cmd('BufWritePost', '.xresources', '__xresources', function(_)
  vim.cmd('!xrdb -DPYWAL_="<$HOME/.cache/wal/colors.Xresources>" -merge ~/.xresources')
end)

-- Automatically compile suckless programs on write
-- Need to clear the autogroup first to avoid stacking commands
local group = '__suckless'
vim.api.nvim_create_augroup(group, { clear = true })
for _, v in ipairs({
  '*/dwm/**/config.h',
  '*/st/**/config.h',
  '*/dmenu/**/config.h',
  '*/slock/**/config.h',
}) do
  vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = v,
    group = vim.api.nvim_create_augroup(group, {
      clear = false,
    }),
    callback = function()
      vim.cmd(string.format('!sudo make clean install', v))
    end,
  })
end

-- Dwmblocks requires additional process termination on top of simply running 'make'
au_cmd('BufWritePost', '*/dwmblocks/config.h', '__dwmblocks', function(_)
  vim.cmd('!cd ~/.config/dwmblocks/; sudo make install; kill $(pidof -s dwmblocks) >/dev/null; dwmblocks &')
end)

-- disables auto-comment continuations for .py files (some filetypes have their format-options overwritten by ftplugins)
vim.cmd([[autocmd BufRead,BufNew,BufEnter *.py* set formatoptions-=cro shiftwidth=4 tabstop=4 expandtab]])
