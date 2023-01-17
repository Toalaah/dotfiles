local M = {}

-- Saves and re-sources a lua module
M.reload_module = function()
  if vim.bo.filetype ~= 'lua' then
    vim.notify('Not in a lua module', vim.log.levels.WARN)
    return
  end
  vim.cmd.write()
  local ok, _ = pcall(vim.api.nvim_command, 'luafile %')
  if not ok then
    vim.notify(
      string.format('An error occurred when attempting to reload lua file: %s', vim.fn.expand '%'),
      vim.log.levels.ERROR
    )
  else
    vim.notify(string.format('Reloaded lua module: %s', vim.fn.expand '%'), vim.log.levels.INFO)
  end
end

return M
