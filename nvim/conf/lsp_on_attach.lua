function(client, bufnr)
  local opts = { silent = true, buffer = bufnr }
  vim.keymap.set('n', '<leader>lD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>lR', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<leader>p', function() vim.lsp.buf.format { async = true } end, opts)

  client.server_capabilities.semanticTokensProvider = nil
end
