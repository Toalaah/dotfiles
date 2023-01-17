local M = {
  'jose-elias-alvarez/null-ls.nvim',
  dependencies = { {'nvim-lua/plenary.nvim'}, {"hrsh7th/cmp-nvim-lsp"} },
  event = 'VeryLazy'
}

M.config = function()
  local nls = require 'null-ls'
  nls.setup {
    debounce = 150,
    save_after_format = false,
    sources = {
      nls.builtins.formatting.stylua,
      nls.builtins.formatting.shfmt,
      nls.builtins.formatting.black,

      nls.builtins.diagnostics.shellcheck,
      nls.builtins.diagnostics.flake8,

      nls.builtins.code_actions.shellcheck,
    },
    root_dir = require('null-ls.utils').root_pattern '.git',
  }
end

return M
