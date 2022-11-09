---@param name string
local lsp_format = function(name)
  return function()
    vim.lsp.buf.format({ name = name })
    vim.cmd('w')
  end
end

require('formatter').setup({
  filetype = {
    ['*'] = { require('formatter.filetypes.any').remove_trailing_whitespace },
    c = { require('formatter.filetypes.c').clangformat },
    cpp = { require('formatter.filetypes.cpp').clangformat },
    dart = { require('formatter.filetypes.dart').dartformat },
    go = { require('formatter.filetypes.go').gofmt },
    json = lsp_format('jsonls'),
    latex = { require('formatter.filetypes.latex').latexindent },
    lua = { require('formatter.filetypes.lua').stylua },
    python = { require('formatter.filetypes.python').black },
    ruby = { require('formatter.filetypes.ruby').rubocop },
    rust = { require('formatter.filetypes.rust').rustfmt },
    sh = { require('formatter.filetypes.sh').shfmt },
    typescript = lsp_format('tsserver'),
    typescriptreact = lsp_format('tsserver'),
    yaml = { require('formatter.filetypes.yaml').yamlfmt },
  },
})
