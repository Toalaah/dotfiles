filetype plugin on

call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release', 'dir': '../pack/coc/coc.nvim-release/plugin/coc.vim'}
Plug 'morhetz/gruvbox'
call plug#end()
colorscheme gruvbox
set background=dark
set nocompatible
set backspace=2
syntax on
set wrap!
set tabstop=4
set shellcmdflag=-ic

autocmd BufWritePost *.tex silent! !pdf <afile>
augroup WrapLineInTeXFile
    autocmd!
    autocmd FileType tex setlocal wrap
augroup END

augroup WrapLineInMDFile
    autocmd!
    autocmd FileType md setlocal wrap
augroup END




set expandtab
set shiftwidth=4
nnoremap <CR> :noh<CR><CR>
set number relativenumber 
set clipboard+=unnamedplus

function! CleverTab()
           if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
              return "\<Tab>"
           else
              return "\<C-N>"
           endif
        endfunction
        inoremap <Tab> <C-R>=CleverTab()<CR>


"vmap '' :w !pbcopy<CR><CR>
