require('rose-pine').setup {}
vim.cmd [[ colorscheme rose-pine ]]
vim.api.nvim_set_hl(0, 'WinSeperator', { bg = 'None' })

-- apply border to builtin lsp hover
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'single',
})
