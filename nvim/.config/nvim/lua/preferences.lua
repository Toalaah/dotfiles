vim.cmd('set encoding=utf-8')         -- set default encoding standard
vim.cmd('set hidden')                 -- allows switching buffers without saving them
vim.cmd('set shortmess+=c')           -- disable 'pattern not found' message from compe
vim.cmd('set relativenumber')         -- relative line numbering, better for jumps
vim.cmd('set termguicolors')          -- enable 24-bit rgb
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
vim.cmd('set nowrap')                 -- disable linewrapping
vim.cmd('set noshowmode')             -- disables messages below the tabline
vim.cmd('set clipboard+=unnamedplus') -- enables copy / pasting to and from the buffer
vim.cmd('set showtabline=2')          -- always show tab-bar
vim.cmd('set mouse=a')                -- enable mouse usage
vim.cmd('set autoindent')             -- auto-indenting
vim.cmd('colorscheme gruvbox')        -- set colorscheme
vim.cmd('set bg=dark')                -- set background-color
vim.cmd('let g:blamer_enabled=1')     -- enable 'gitlens'-feature

-- Enable alpha
vim.cmd('autocmd BufRead,BufNew,BufEnter * highlight Normal guibg=none')
-- disables auto-comment continuations for all files.
-- Some files have their format-options overwritten by
-- ftplugins; this ensures that they are set correctly
vim.cmd('autocmd BufRead,BufNew,BufEnter *.py* set formatoptions-=cro shiftwidth=4 tabstop=4 expandtab')
-- run xrdb on changes to xresources
vim.cmd('autocmd BufWritePost ~/.xresources !xrdb -DPYWAL_="<$HOME/.cache/wal/colors.Xresources>" -merge ~/.xresources')
-- recompile dwm config on write
vim.cmd('autocmd BufWritePost ~/.config/dwm/config.h !cd ~/.config/dwm/; sudo make install')
-- recompile st config on write
vim.cmd('autocmd BufWritePost ~/.config/st/config.h !cd ~/.config/st/; sudo make install')
-- recompile + restart dwmblocks config on write
-- (yes, this is a very ugly way of doing this)
vim.cmd('autocmd BufWritePost ~/.config/dwmblocks/config.h !cd ~/.config/dwmblocks/; sudo make install; kill $(pidof -s dwmblocks) >/dev/null; dwmblocks &')
-- recompile dmenu config on write
vim.cmd('autocmd BufWritePost ~/.config/dmenu/config.h !cd ~/.config/dmenu/; sudo make install')
-- recompile slock config on write
vim.cmd('autocmd BufWritePost ~/.config/slock/config.h !cd ~/.config/slock/; sudo make install')
-- set filetype to bash for all .sh files
vim.cmd('autocmd BufRead,BufNew,BufEnter *.sh* set syntax=bash')
-- disable error highlighting in json files
vim.cmd('autocmd BufRead,BufNew,BufEnter *.json* hi Error NONE')

