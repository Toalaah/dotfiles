local u = require('plugins.util')
local plugin = u.plugin

-- bootstrap packer installation if required
local did_bootstrap = u.bootstrap_packer()

local plugin_list = {
  -- 'Core' plugins. Frequently used as dependencies for other plugins
  'nvim-lua/plenary.nvim',
  'nvim-treesitter/nvim-treesitter',
  'nvim-telescope/telescope.nvim',
  'kyazdani42/nvim-web-devicons',

  -- Aesthetics & Colorschemes
  'Yazeed1s/minimal.nvim',
  'folke/tokyonight.nvim',
  'projekt0n/github-nvim-theme',
  'folke/zen-mode.nvim', -- minimal, distraction-free editing mode
  'hoob3rt/lualine.nvim', -- statusline
  'akinsho/nvim-bufferline.lua', -- bufferline

  -- LSP
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',

  -- Completion engine & snippets
  'hrsh7th/nvim-cmp',
  'onsails/lspkind-nvim',
  'hrsh7th/cmp-nvim-lsp',
  'saadparwaiz1/cmp_luasnip',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-nvim-lua',
  'rafamadriz/friendly-snippets',
  'L3MON4D3/LuaSnip',

  -- Utility
  'numToStr/Comment.nvim', -- improved commenting motions
  'romainl/vim-cool', -- automatically set 'noh' after searching

  -- Git
  'tpope/vim-fugitive',
  'lewis6991/gitsigns.nvim',
}

return require('packer').startup({
  function(use)
    -- packer manager
    use('wbthomason/packer.nvim')

    for _, p in ipairs(plugin_list) do
      use(plugin(p))
    end

    use({
      'ghillb/cybu.nvim',
      branch = 'v1.x', -- won't receive breaking changes
      -- branch = "main", -- timely updates
      config = function()
        local ok, cybu = pcall(require, 'cybu')
        if not ok then
          return
        end
        cybu.setup()
        vim.keymap.set('n', 'H', '<Plug>(CybuPrev)')
        vim.keymap.set('n', 'L', '<Plug>(CybuNext)')
      end,
    })
    use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })

    -- git integration
    use({
      'lukas-reineke/lsp-format.nvim',
      tag = 'v1',
      config = function()
        require('plugins.lsp-format.lsp-format-config')
      end,
    })
    use({
      'folke/todo-comments.nvim',
      config = function()
        require('todo-comments').setup({})
      end,
    })
    use({
      'filipdutescu/renamer.nvim',
      branch = 'master',
      config = function()
        require('plugins.renamer.renamer-config')
      end,
    })
    use({
      'folke/trouble.nvim',
      requires = 'kyazdani42/nvim-web-devicons',
      config = function()
        require('plugins.trouble.trouble-config')
      end,
    })

    -- terminal integration
    use(plugin('voldikss/vim-floaterm'))

    -- flutter / dart development
    use({
      'akinsho/flutter-tools.nvim',
      config = function()
        require('plugins.flutter-tools.flutter-tools-config')
      end,
    })
    use(plugin('dart-lang/dart-vim-plugin'))

    -- file / buffer navigation
    use({
      'kyazdani42/nvim-tree.lua',
      config = function()
        require('plugins.nvim-tree.nvim-tree-config')
      end,
    })

    use(plugin('folke/which-key.nvim'))

    use({
      'iamcco/markdown-preview.nvim',
      run = 'cd app && yarn install',
    })

    if did_bootstrap then
      require('packer').sync()
    end
  end,

  config = {
    display = {
      open_fn = require('packer.util').float,
    },
  },
})
