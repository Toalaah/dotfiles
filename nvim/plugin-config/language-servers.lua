require'lspconfig'.clangd.setup{}
require'lspconfig'.pyright.setup{}
require'lspconfig'.vimls.setup{}
require'lspconfig'.tsserver.setup{}
-- Sometimes the tex-lsp is not found unless the 
-- appropriate filetypes are explicitly provided
require'lspconfig'.texlab.setup{ filetypes = { ".tex", ".bib" } }
require'lspconfig'.bashls.setup{}
