---@param event string
---@param pattern string
---@param group string
---@param callback function
local au_cmd = function(event, pattern, group, callback)
  vim.api.nvim_create_autocmd(event, {
    pattern = pattern,
    group = vim.api.nvim_create_augroup(group, { clear = true }),
    callback = callback,
  })
end

au_cmd('BufEnter', '*.env*', '__env', function(args)
  vim.diagnostic.disable(args.buf)
  vim.bo.filetype = 'sh'
end)

au_cmd('BufWritePost', '*/plugins/init.lua', '__packer', function(_)
  vim.cmd([[
      luafile %
      PackerCompile
    ]])
end)
