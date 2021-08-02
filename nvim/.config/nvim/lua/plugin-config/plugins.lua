 --[[
  __   _(_)_ __ ___  _ __ ___
  \ \ / / | '_ ` _ \| '__/ __|
   \ V /| | | | | | | | | (__   v3
    \_/ |_|_| |_| |_|_|  \___|  07/21
--]]


return require('packer').startup(function()
	use {'wbthomason/packer.nvim' }
	use { 'gruvbox-community/gruvbox' }
        use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	use { 'neovim/nvim-lspconfig' }
	use { 'tpope/vim-fugitive' }
	use { 'itchyny/lightline.vim' }
	use { 'mengelbrecht/lightline-bufferline' }
	use { 'jiangmiao/auto-pairs' }
	use { 'b3nj5m1n/kommentary' }
	use { 'iamcco/markdown-preview.nvim' }

	-- Telescope stuff
	use { 'nvim-lua/popup.nvim' }
	use { 'nvim-lua/plenary.nvim' }              
	use { 'nvim-telescope/telescope.nvim' }
end)


-- TODO: nvim-compe
