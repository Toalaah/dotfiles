call plug#begin('~/.config/nvim/autoload/plugged')
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'morhetz/gruvbox'
	Plug 'itchyny/lightline.vim'
	Plug 'itchyny/vim-gitbranch'
	Plug 'lervag/vimtex'
    Plug 'tpope/vim-fugitive'
    Plug 'preservim/nerdtree'
call plug#end()
" Add fuzzysearch
set runtimepath^=~/.config/ctrlp/ctrlp.vim
