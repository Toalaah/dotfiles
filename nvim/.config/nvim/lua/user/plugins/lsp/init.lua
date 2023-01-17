return {
  -- lsp managers
  require 'user.plugins.lsp.mason',
  -- completion + snippets
  require 'user.plugins.lsp.cmp',
  -- null-ls (formatting, diagnostics, etc.)
  require 'user.plugins.lsp.null-ls',
  -- diagnostics
  require 'user.plugins.lsp.trouble',
  -- specialized language plugins
  { 'simrat39/rust-tools.nvim', lazy = true },
  { 'akinsho/flutter-tools.nvim', lazy = true },
}
