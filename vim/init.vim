source $HOME/config/vim/key-mappings.vim
source $HOME/config/vim/preferences.vim
source $HOME/config/vim/functions.vim

call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release', 'dir': '../pack/coc/coc.nvim-release/plugin/coc.vim'}
Plug 'morhetz/gruvbox'
Plug 'davidhalter/jedi-vim'
Plug 'itchyny/lightline.vim'
call plug#end()

set noshowmode "for lightline"
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ }

colorscheme gruvbox
set background=dark

nnoremap <CR> :noh<CR><CR>



