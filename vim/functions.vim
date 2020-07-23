autocmd BufWritePost *.tex silent! !pdf <afile>
augroup WrapLineInTeXFile
    autocmd!
    autocmd FileType tex setlocal wrap
augroup END

augroup WrapLineInMDFile
    autocmd!
    autocmd FileType md setlocal wrap
augroup END


function! CleverTab()
           if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
              return "\<Tab>"
           else
              return "\<C-N>"
           endif
        endfunction
        inoremap <Tab> <C-R>=CleverTab()<CR>

