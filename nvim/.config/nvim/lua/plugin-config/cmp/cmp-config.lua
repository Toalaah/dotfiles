local luasnip = require('luasnip')
local lspkind = require('lspkind')
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-l>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
  },
  experimental = {
    ghost_text = true,
  },
  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
      menu = {
        nvim_lsp = '[LSP]',
        nvim_lua = '[Vim]',
        luasnip = '[Snip]',
        path = '[Path]',
        buffer = '[Buff]',
      },
    }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer', keyword_length = 5, max_item_count = 5 },
    { name = 'path' },
    { name = 'luasnip', max_item_count = 5 },
    { name = 'nvim_lua' },
  },
})
