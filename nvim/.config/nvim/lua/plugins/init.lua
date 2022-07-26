local u = require('plugins.util')
local plugin = u.plugin

-- bootstrap packer installation if required
local did_bootstrap = u.bootstrap_packer()

---@diagnostic disable-next-line: unused-local
local plugin_list = {
  lsp = {},
  git = {},
  colorscheme = {},
}

return require('packer').startup(function(use)
  -- packer manager
  use('wbthomason/packer.nvim')

  -- 'Core' plugins. Frequently used as dependencies for other plugins
  use(plugin('nvim-lua/plenary.nvim'))
  use(plugin('nvim-treesitter/nvim-treesitter'))
  use(plugin('nvim-telescope/telescope.nvim'))

  use(plugin('numToStr/Comment.nvim'))
  use({
    'ghillb/cybu.nvim',
    branch = 'v1.x', -- won't receive breaking changes
    -- branch = "main", -- timely updates
    requires = { 'kyazdani42/nvim-web-devicons' }, --optional
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

  -- colorschemes
  use(plugin('Yazeed1s/minimal.nvim'))
  use(plugin('folke/tokyonight.nvim'))
  use(plugin('projekt0n/github-nvim-theme'))

  -- git integration
  use('tpope/vim-fugitive')
  use({
    'lewis6991/gitsigns.nvim',
    config = function()
      require('plugins.gitsigns.gitsigns-config')
    end,
  })

  -- lsp / auto-formatting
  use(plugin('williamboman/mason.nvim'))
  use(plugin('williamboman/mason-lspconfig.nvim'))
  use(plugin('neovim/nvim-lspconfig'))
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

  -- auto-completion / snippets
  use(plugin('hrsh7th/nvim-cmp'))
  use(plugin('onsails/lspkind-nvim'))
  use(plugin('hrsh7th/cmp-nvim-lsp'))
  use(plugin('saadparwaiz1/cmp_luasnip'))
  use(plugin('hrsh7th/cmp-buffer'))
  use(plugin('hrsh7th/cmp-path'))
  use(plugin('hrsh7th/cmp-nvim-lua'))
  use(plugin('rafamadriz/friendly-snippets'))
  use(plugin('L3MON4D3/LuaSnip'))

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

  -- rust development
  use({
    'simrat39/rust-tools.nvim',
    requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    config = function()
      require('plugins.rust-tools.rust-tools-config')
    end,
  })

  -- status/buffer line
  use({
    'hoob3rt/lualine.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require('plugins.lualine.lualine-config')
    end,
  })
  use({
    'akinsho/nvim-bufferline.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require('plugins.bufferline.bufferline-config')
    end,
  })

  -- file / buffer navigation
  use({
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require('plugins.nvim-tree.nvim-tree-config')
    end,
  })

  use(plugin('folke/which-key.nvim'))

  use({
    'iamcco/markdown-preview.nvim',
    run = 'cd app && yarn install',
  })
  use(plugin('folke/zen-mode.nvim'))

  -- automatically set 'noh' after searching
  use(plugin('romainl/vim-cool'))

  if did_bootstrap then
    require('packer').sync()
  end
end)
