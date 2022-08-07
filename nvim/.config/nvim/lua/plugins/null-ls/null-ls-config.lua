local n = require('null-ls')
local opts = {
  sources = {
    n.builtins.formatting.stylua,
    n.builtins.formatting.autopep8,
    n.builtins.formatting.prettier.with({
      filetypes = { 'html', 'json', 'yaml', 'markdown' },
    }),
  },
}

n.setup(opts)
