
"       _
"__   _(_)_ __ ___  _ __ ___
"\ \ / / | '_ ` _ \| '__/ __|
" \ V /| | | | | | | | | (__   v2
"  \_/ |_|_| |_| |_|_|  \___|  05/21
"
" Plugins

call plug#begin('~/.vim/plugged')
    Plug 'morhetz/gruvbox'                      " Colorscheme of choice
    Plug 'tpope/vim-fugitive'                   " Git wrapper
    Plug 'itchyny/lightline.vim'                " Minimal statusbar
    Plug 'neovim/nvim-lspconfig'                " LSP Functionality
    Plug 'psliwka/vim-smoothie'                 " Enable smooth scrolling through files
    Plug 'hrsh7th/nvim-compe'                   " Autocomplete
    Plug 'mengelbrecht/lightline-bufferline'    " Lightline plugin, show open buffers in tabline
    Plug 'nvim-lua/popup.nvim'                  " Requirement for telescope
    Plug 'nvim-lua/plenary.nvim'                " Requirement for telescope
    Plug 'nvim-telescope/telescope.nvim'        " Cross-file fuzzyfinder
    Plug 'sheerun/vim-polyglot'                 " Improved syntax highlighting
    Plug 'airblade/vim-gitgutter'               " Show git changes in sidebar
call plug#end() 



" Lightline configuration

let g:lightline = {
    \ 'colorscheme': 'jellybeans',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'FugitiveHead'
    \ },
    \ 'tabline': {
    \   'left': [ ['buffers'] ],
    \   'right': [ ['close'] ]
    \ },
    \ 'component_expand': {
    \   'buffers': 'lightline#bufferline#buffers'
    \ },
    \ 'component_type': {
    \   'buffers': 'tabsel'
    \ }
    \ }
