"" compile tex files on write
autocmd BufWritePost *.tex silent! !pdf <afile>
"" enable line-wrap when working with tex files
au BufRead,BufNewFile *.tex setlocal wrap
"" enable line-wrap when working with md files
au BufRead,BufNewFile *.md setlocal wrap
" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"" Enable tabbing through open buffers
function! CleverTab()
           if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
              return "\<Tab>"
           else
              return "\<C-N>"
           endif
        endfunction
        inoremap <Tab> <C-R>=CleverTab()<CR>
