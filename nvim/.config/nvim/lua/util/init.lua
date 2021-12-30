local M = {}

M.toggleSignColumn = function ()
  if vim.o.signcolumn == 'yes' then
    vim.o.signcolumn = 'no'
    return
  end
  vim.o.signcolumn = 'yes'
end

return M
