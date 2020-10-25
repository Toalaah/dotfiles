call plug#begin('~/.config/nvim/autoload/plugged')
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'morhetz/gruvbox'
	Plug 'itchyny/lightline.vim'
	Plug 'itchyny/vim-gitbranch'
	Plug 'tpope/vim-fugitive'
call plug#end()

colorscheme gruvbox
set background=dark
