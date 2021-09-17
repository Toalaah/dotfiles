local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

return require('packer').startup(function(use)
  -- packer
  use { 'wbthomason/packer.nvim' }

  -- colorschemes
  use { 'gruvbox-community/gruvbox' }

  -- git integration
  use { 'tpope/vim-fugitive' }
  use { 'mhinz/vim-signify' }
  use { 'apzelos/blamer.nvim' }

  -- lsp / auto-completion
  use { 'hrsh7th/nvim-compe' }
  use { 'neovim/nvim-lspconfig' }
  use { 'kabouzeid/nvim-lspinstall' }

  -- status/buffer-lines
  use { 'hoob3rt/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons' } }
  use { 'akinsho/nvim-bufferline.lua', requires = { 'kyazdani42/nvim-web-devicons' } }

  -- misc
  use { 'b3nj5m1n/kommentary' }
  use { 'iamcco/markdown-preview.nvim' }
  use { 'karb94/neoscroll.nvim' }
  use { 'mhinz/vim-startify' }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'dbeniamine/cheat.sh-vim' }
  use { 'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons' } }
  use { 'romainl/vim-cool' }

  -- telescope
  use { 'nvim-lua/popup.nvim' }
  use { 'nvim-lua/plenary.nvim' }
  use { 'nvim-telescope/telescope.nvim' }

  if not packer_exists then vim.api.nvim_command 'PackerSync' end
end)

