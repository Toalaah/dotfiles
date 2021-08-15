vim.cmd('set encoding=utf-8')         -- set default encoding standard
vim.cmd('set hidden')                 -- allows switching buffers without saving them
vim.cmd('set shortmess+=c')           -- disable 'pattern not found' message from compe
vim.cmd('set relativenumber')         -- relative line numbering, better for jumps
vim.cmd('set termguicolors')          -- enable 24-bit rgb
-- vim.cmd('set nohlsearch')             -- disables matched words becoming highlighted
vim.cmd('set tabstop=2')              -- sets tab-length to 2 instead of the default 8
vim.cmd('set shiftwidth=2')           -- enables auto-indenting to the same degree of tab-lengths
vim.cmd('set expandtab')              -- converts all tabs to spaces on save
vim.cmd('set nu')                     -- show numbers on side
vim.cmd('set noswapfile')             -- disable swap-files
vim.cmd('set nobackup')               -- disable backup files
vim.cmd('set incsearch')              -- incremental searching
vim.cmd('set ignorecase')             -- searching ignores case
vim.cmd('set cursorline')             -- highlights current line
vim.cmd('set scrolloff=8')            -- always show 8 lines on the top / bottom of the buffer when scrolling
vim.cmd('set noshowmode')             -- disables messages below the tabline
vim.cmd('set clipboard+=unnamedplus') -- enables copy / pasting to and from the buffer
vim.cmd('set showtabline=2')          -- always show tab-bar
vim.cmd('set mouse=a')                -- enable mouse usage
vim.cmd('set autoindent')             -- auto-indenting
vim.cmd('colorscheme gruvbox')        -- set colorscheme
vim.cmd('set bg=dark')                -- set background-color 

-- disables auto-comment continuations for all files. 
-- Some files have their format-options overwritten by
-- ftplugins; this ensures that they are set correctly
vim.cmd('autocmd BufRead,BufNew,BufEnter *.* set formatoptions-=cro') 

