local u = require('plugins.util')
local plugin = u.plugin

-- bootstrap packer installation if required
u.bootstrap_packer()

local plugin_list = {
  -- 'Core' plugins. Frequently used as dependencies for other plugins
  'wbthomason/packer.nvim',
  'nvim-lua/plenary.nvim',
  'nvim-treesitter/nvim-treesitter',
  'nvim-telescope/telescope.nvim',
  'kyazdani42/nvim-web-devicons',
  'lewis6991/impatient.nvim',

  -- Aesthetics & Colorschemes
  'folke/tokyonight.nvim',
  'sam4llis/nvim-tundra',
  'folke/zen-mode.nvim',
  'hoob3rt/lualine.nvim',
  'akinsho/bufferline.nvim',
  'norcalli/nvim-colorizer.lua',
  'rcarriga/nvim-notify',
  'elkowar/yuck.vim',

  -- LSP
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',
  'glepnir/lspsaga.nvim',
  'mhartington/formatter.nvim',
  'gpanders/editorconfig.nvim',

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
  'numToStr/Comment.nvim',
  'JoosepAlviste/nvim-ts-context-commentstring',
  'kyazdani42/nvim-tree.lua',
  'romainl/vim-cool',
  { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
  { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install' },
  'folke/which-key.nvim',
  'voldikss/vim-floaterm',
  'akinsho/git-conflict.nvim',
  'ekickx/clipboard-image.nvim',

  -- File & buffer navigation
  'ghillb/cybu.nvim',

  -- Git
  'tpope/vim-fugitive',
  'lewis6991/gitsigns.nvim',
}

return require('packer').startup({
  function(use)
    for _, p in ipairs(plugin_list) do
      use(plugin(p))
    end

    if u.did_bootstrap then
      require('packer').sync()
    end
  end,
})
