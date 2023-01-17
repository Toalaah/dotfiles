local M = {
  'hrsh7th/nvim-cmp',
  event = { 'InsertEnter', 'CmdlineEnter' },
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp', lazy = true },
    { 'hrsh7th/cmp-nvim-lua', lazy = true },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-cmdline' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'onsails/lspkind.nvim' },
    {
      'zbirenbaum/copilot-cmp',
      config = function() require('copilot_cmp').setup() end,
    },
    -- snippets
    { 'rafamadriz/friendly-snippets', lazy = true },
    { 'L3MON4D3/LuaSnip', lazy = true },
  },
}

-- initializes & configures nvim cmp + snippets engine
M.config = function()
  local luasnip = require 'luasnip'
  local cmp = require 'cmp'
  local lspkind = require 'lspkind'

  require('luasnip.loaders.from_vscode').lazy_load()
  cmp.setup {
    enabled = function()
      local is_prompt = vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt'
      local is_modifiable = vim.api.nvim_buf_get_option(0, 'modifiable')
      return not is_prompt and is_modifiable
    end,
    completion = {
      autocomplete = {
        cmp.TriggerEvent.TextChanged,
        cmp.TriggerEvent.InsertEnter,
      },
    },
    snippet = {
      expand = function(args) luasnip.lsp_expand(args.body) end,
    },
    formatting = {
      format = lspkind.cmp_format {
        symbol_map = { Copilot = '' },
        mode = 'symbol',
        menu = {
          nvim_lsp = '[LSP]',
          nvim_lua = '[Vim]',
          luasnip = '[Snip]',
          path = '[Path]',
          buffer = '[Buff]',
          copilot = '[Copilot]',
        },
      },
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert {
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'buffer' },
      { name = 'orgmode' },
      { name = 'copilot' },
      { name = 'luasnip' },
      { name = 'nvim_lua' },
    },
  }

  -- Use buffer source for `/` and `?`
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' },
    },
  })

  -- Use cmdline & path source for ':'
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'path' },
      { name = 'cmdline' },
    },
  })
end

return M
