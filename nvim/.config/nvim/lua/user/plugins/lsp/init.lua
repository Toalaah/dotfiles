return {
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    keys = { { '<leader>lM', '<cmd>Mason<cr>', desc = 'Mason' } },
    opts = {
      ensure_installed = { 'stylua', 'shellcheck', 'shfmt' },
    },
    config = true,
  },

  {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    dependencies = { 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim', 'hrsh7th/cmp-nvim-lsp' },
    opts = function()
      local lsp_configs = require 'user.plugins.lsp.config'
      return {
        ensure_installed = { 'lua_ls' },
        servers = lsp_configs,
      }
    end,
    config = function(_, opts)
      local server_opts = opts.servers
      local on_attach = require('user.plugins.lsp.util').on_attach
      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      local mason_lsp = require 'mason-lspconfig'
      local merge_config = function(server_name)
        return vim.tbl_deep_extend('force', server_opts[server_name] or {}, {
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end
      mason_lsp.setup { ensure_installed = opts.ensure_installed }
      mason_lsp.setup_handlers {
        function(server_name) require('lspconfig')[server_name].setup(merge_config(server_name)) end,
      }
    end,
  },
  -- completion
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-cmdline' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'onsails/lspkind.nvim' },
      { 'zbirenbaum/copilot-cmp', opts = {} },
      { 'rafamadriz/friendly-snippets' },
      { 'L3MON4D3/LuaSnip' },
    },
    config = function(_, _opts)
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
          { name = 'copilot' },
          { name = 'path' },
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
    end,
  },
  -- diagnostics, etc.
  {
    'folke/trouble.nvim',
    cmd = { 'Trouble', 'TroubleToggle' },
    opts = { use_diagnostic_signs = true },
  },
  -- null-ls
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = 'BufReadPre',
    dependencies = { 'mason.nvim' },
    opts = function()
      local nls = require 'null-ls'
      return {
        debounce = 150,
        save_after_format = false,
        root_dir = require('null-ls.utils').root_pattern '.git',
        sources = {
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.shfmt,
          nls.builtins.formatting.black,

          nls.builtins.diagnostics.shellcheck,
          nls.builtins.diagnostics.flake8,

          nls.builtins.code_actions.shellcheck,
        },
      }
    end,
  },
  -- copilot
  { 'zbirenbaum/copilot.lua', event = 'InsertEnter', opts = {} },
}
