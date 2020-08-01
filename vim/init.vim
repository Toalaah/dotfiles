filetype plugin on


source ~/config/vim/key-mappings.vim
source ~/config/vim/preferences.vim
source ~/config/vim/functions.vim

call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release', 'dir': '../pack/coc/coc.nvim-release/plugin/coc.vim'}
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'tpope/vim-fugitive'
call plug#end()

"set noshowmode for lightline"
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

colorscheme gruvbox
set background=dark

nnoremap <CR> :noh<CR><CR>

