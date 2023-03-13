local lsp_formatting = function(bufnr)
  return function()
    vim.lsp.buf.format {
      filter = function(client) return client.name == 'null-ls' end,
      bufnr = bufnr,
      async = false,
    }
    vim.cmd.write()
  end
end

local M = {}

M.on_attach = function(client, bufnr)
  local bufopts = { silent = true, buffer = bufnr }
  local nnoremap = require('util.keybindings').nnoremap
  if client.supports_method 'textDocument/formatting' then
    nnoremap('<leader>p', lsp_formatting(bufnr), 'Format file', bufopts)
  end
  nnoremap('<leader>lD', vim.lsp.buf.declaration, 'Goto declaration', bufopts)
  nnoremap(
    '<leader>lw',
    function() vim.pretty_print(vim.lsp.buf.list_workspace_folders()) end,
    'List workspaces',
    bufopts
  )
  nnoremap('K', vim.lsp.buf.hover, 'Hover', bufopts)
  -- nnoremap('<leader>lR', vim.lsp.buf.rename, 'Rename', bufopts)
  nnoremap(
    '<leader>lR',
    function() return ':IncRename ' .. vim.fn.expand '<cword>' end,
    'Rename',
    { buffer = bufnr, expr = true }
  )
  nnoremap('<leader>la', vim.lsp.buf.code_action, 'Code action', bufopts)
  -- nnoremap('<leader>ld', vim.lsp.buf.definition, bufopts)
  -- nnoremap('<leader>li', vim.lsp.buf.implementation, bufopts)
  -- nnoremap('<leader>lr', vim.lsp.buf.references, bufopts)
  nnoremap('<leader>lx', vim.diagnostic.open_float, 'Open diagnostics (QF)', bufopts)
  nnoremap('<leader>le', '<Cmd>Trouble document_diagnostics<CR>', 'Open diagnostics (QF)', bufopts)
  nnoremap('<leader>ld', '<Cmd>Trouble lsp_definitions<CR>', 'Goto definition', bufopts)
  nnoremap('<leader>li', '<Cmd>TroubleToggle lsp_implementations<CR>', 'View implementations', bufopts)
  nnoremap('<leader>lr', '<Cmd>TroubleToggle lsp_references<CR>', 'View references', bufopts)
end

return M
