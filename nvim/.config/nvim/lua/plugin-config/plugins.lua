-- bootstrap packer installation
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  Packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  })
  vim.cmd('packadd packer.nvim')
end

return require('packer').startup(function(use)
  -- packer manager
  use({
    'wbthomason/packer.nvim',
  })

  -- treesitter
  use({
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('plugin-config.treesitter.treesitter-config')
    end,
  })

  -- telescope + telescope extensions / dependencies
  use({
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('plugin-config.telescope.telescope-config')
    end,
  })
  use({ 'nvim-lua/popup.nvim' })
  use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
  use({ 'jvgrootveld/telescope-zoxide' })
  use({ 'camgraff/telescope-tmux.nvim' })

  -- colorschemes
  use({
    'ellisonleao/gruvbox.nvim',
    requires = {
      'rktjmp/lush.nvim',
    },
  })
  use({
    'navarasu/onedark.nvim',
  })
  use({ 'whatsthatsmell/codesmell_dark.vim' })
  use({ 'folke/tokyonight.nvim' })
  use({ 'rebelot/kanagawa.nvim' })

  -- git integration
  use({
    'tpope/vim-fugitive',
  })
  use({
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('plugin-config.gitsigns.gitsigns-config')
    end,
  })

  -- lsp / auto-formatting
  use({
    'neovim/nvim-lspconfig',
  })
  use({
    'williamboman/nvim-lsp-installer',
    config = function()
      require('plugin-config.lsp-installer.lsp-installer-config')
    end,
  })
  use({
    'lukas-reineke/lsp-format.nvim',
    tag = 'v1',
    config = function()
      require('plugin-config.lsp-format.lsp-format-config')
    end,
  })
  use({
    'filipdutescu/renamer.nvim',
    branch = 'master',
    requires = { { 'nvim-lua/plenary.nvim' } },
    config = function()
      require('plugin-config.renamer.renamer-config')
    end,
  })
  use({
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('plugin-config.trouble.trouble-config')
    end,
  })

  -- auto-completion / snippets
  use({ 'onsails/lspkind-nvim' })
  use({
    'hrsh7th/nvim-cmp',
    config = function()
      require('plugin-config.cmp.cmp-config')
    end,
  })
  use({
    'hrsh7th/cmp-nvim-lsp',
  })
  use({
    'saadparwaiz1/cmp_luasnip',
  })
  use({ 'hrsh7th/cmp-buffer' })
  use({ 'hrsh7th/cmp-path' })
  use({ 'hrsh7th/cmp-nvim-lua' })
  use({
    'L3MON4D3/LuaSnip',
    config = function()
      require('plugin-config.luasnip.luasnip-config')
    end,
  })
  use({
    'rafamadriz/friendly-snippets',
  })

  -- terminal integration
  use({
    'voldikss/vim-floaterm',
    config = function()
      require('plugin-config.floaterm.floaterm-config')
    end,
  })

  -- flutter / dart development
  use({
    'akinsho/flutter-tools.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('plugin-config.flutter-tools.flutter-tools-config')
    end,
  })
  use({
    'dart-lang/dart-vim-plugin',
  })

  -- rust development
  use({
    'simrat39/rust-tools.nvim',
    requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    config = function()
      require('plugin-config.rust-tools.rust-tools-config')
    end,
  })

  -- status/buffer line
  use({
    'hoob3rt/lualine.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require('plugin-config.lualine.lualine-config')
    end,
  })
  use({
    'akinsho/nvim-bufferline.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require('plugin-config.bufferline.bufferline-config')
    end,
  })

  -- file / buffer navigation
  use({
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require('plugin-config.nvim-tree.nvim-tree-config')
    end,
  })

  -- keymappings
  use({
    'folke/which-key.nvim',
    config = function()
      require('plugin-config.which-key.which-key-config')
    end,
  })

  -- misc
  use({
    'numToStr/Comment.nvim',
    config = function()
      require('plugin-config.comment.comment-config')
    end,
  })
  use({
    'iamcco/markdown-preview.nvim',
    run = 'cd app && yarn install',
  })
  use({
    'mhinz/vim-startify',
    config = function()
      require('plugin-config.startify.startify-config')
    end,
  })
  use({
    'folke/zen-mode.nvim',
    config = function()
      require('plugin-config.zen-mode.zen-mode-config')
    end,
  })
  use({
    'romainl/vim-cool',
  })

  if Packer_bootstrap then
    require('packer').sync()
  end
end)
