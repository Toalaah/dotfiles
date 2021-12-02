-- bootstrap packer installation
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({
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

  -- telescope / treesitter
  use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('plugin-config.treesitter.treesitter-config')
    end,
  })
  use({
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('plugin-config.telescope.telescope-config')
    end,
  })

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
  use({
    'apzelos/blamer.nvim',
    config = function()
      require('plugin-config.blamer.blamer-config')
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
    'lukas-reineke/format.nvim',
    config = function()
      require('plugin-config.format.format-config')
    end,
  })

  -- auto-completion / snippets
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
    'b3nj5m1n/kommentary',
    config = function()
      require('plugin-config.kommentary.kommentary-config')
    end,
  })
  use({
    'iamcco/markdown-preview.nvim',
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

  if not packer_exists then
    vim.api.nvim_command('PackerSync')
  end
end)
