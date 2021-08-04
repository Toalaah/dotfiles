return require('packer').startup(function()
	use { 'wbthomason/packer.nvim' }
	use { 'gruvbox-community/gruvbox' }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	use { 'neovim/nvim-lspconfig' }
	use { 'tpope/vim-fugitive' }
  use { 'karb94/neoscroll.nvim' }

  -- status/buffer-lines
  use { 'hoob3rt/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons' } }
  use { 'akinsho/nvim-bufferline.lua', requires = { 'kyazdani42/nvim-web-devicons' } }


	use { 'jiangmiao/auto-pairs' }
	use { 'b3nj5m1n/kommentary' }
	use { 'iamcco/markdown-preview.nvim' }

	-- telescope
	use { 'nvim-lua/popup.nvim' }
	use { 'nvim-lua/plenary.nvim' }              
	use { 'nvim-telescope/telescope.nvim' }

  -- auto-completion
  use { 'hrsh7th/nvim-compe' }
end)

