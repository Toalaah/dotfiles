
"       _
"__   _(_)_ __ ___  _ __ ___
"\ \ / / | '_ ` _ \| '__/ __|
" \ V /| | | | | | | | | (__   v2
"  \_/ |_|_| |_| |_|_|  \___|  05/21
"
" General Preferences

let g:mapleader = " "           " Change leader key to spacebar
set relativenumber              " Relative line numbering
set nohlsearch                  " Disable searchterms remaining highlighted
set tabstop=2                   " Set tab-width
set shiftwidth=2                " Set shift-width
set expandtab                   " Expand tabs to spaces
set nu                          " Show current line number
set noswapfile                  " Disable swp files
set nobackup                    " Disables backups
syntax on                       " Enable syntax highlighting
set incsearch                   " Incremental search
set cursorline                  " Highlight current line
set scrolloff=8                 " Scroll offset 
set noshowmode                  " Disable message if in I, V, or R mode
set clipboard+=unnamedplus      " Enable local clipboard copy/pasting
set nowrap                      " Disable line-wrapping
set showtabline=2               " Always show tabline with all currently open buffers
set mouse=a                     " Enable mouse usage
set autoindent                  " Autoindent
set updatetime=300              " Faster update time for LSP clients
set shortmess+=c                " Disable annoying error message from autocomplete
set bg=dark                     " Set dark background
colorscheme gruvbox             " set Colorscheme

" Enable line-wrap when working with tex or markdown files
au BufRead,BufNewFile *.tex setlocal wrap
au BufRead,BufNewFile *.md setlocal wrap
