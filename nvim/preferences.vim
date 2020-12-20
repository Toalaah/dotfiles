filetype plugin on
set expandtab
set shiftwidth=4
set nocompatible
set backspace=2
set mouse=a
syntax on
set wrap!
set tabstop=4
set shellcmdflag=-ic
set number relativenumber 
set clipboard+=unnamedplus
colorscheme gruvbox
set background=dark

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * :Vexplore
augroup END
