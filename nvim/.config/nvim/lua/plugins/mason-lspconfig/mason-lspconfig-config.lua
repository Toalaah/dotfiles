require('mason-lspconfig').setup({
  ensure_installed = {
    'bashls',
    'clangd',
    'eslint',
    'gopls',
    'pyright',
    'sumneko_lua',
    'texlab',
    'tsserver',
    'yamlls',
  },
})

require('mason-lspconfig').setup_handlers({
  function(server_name) -- default handler (optional)
    require('lspconfig')[server_name].setup({})
  end,
  ['sumneko_lua'] = function()
    require('plugins.mason-lspconfig.lua')
  end,
  ['yamlls'] = function()
    require('plugins.mason-lspconfig.yaml')
  end,
})
