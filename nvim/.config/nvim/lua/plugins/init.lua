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
  'lewis6991/impatient.nvim',

  -- Aesthetics & Colorschemes
  'folke/tokyonight.nvim', -- colorscheme of choice
  'folke/zen-mode.nvim', -- minimal, distraction-free editing mode
  'hoob3rt/lualine.nvim', -- statusline
  'lewis6991/spellsitter.nvim', -- smart spellchecker
  'brenoprata10/nvim-highlight-colors', -- preview colors in buffer via virtual text
  'kyazdani42/nvim-tree.lua', -- file tree
  'rcarriga/nvim-notify', -- pretty wrapper for vim.notify()

  -- LSP
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',
  'folke/trouble.nvim',
  { 'lukas-reineke/lsp-format.nvim', tag = 'v1' },
  'filipdutescu/renamer.nvim',
  'jose-elias-alvarez/null-ls.nvim',

  -- Additional language plugins
  -- (Dart / Flutter)
  'akinsho/flutter-tools.nvim',
  'dart-lang/dart-vim-plugin',

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
  { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }, -- Telescope extension
  { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install' },
  'folke/which-key.nvim', -- keymenu
  'folke/todo-comments.nvim', -- manage todo comments
  'ghillb/cybu.nvim', -- buffer navigation
  'voldikss/vim-floaterm', -- terminal integration

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

    if did_bootstrap then
      require('packer').sync()
    end
  end,
})
