local cmd = vim.api.nvim_command
local silent = require('util').call_silent
local colorscheme = 'tokyonight'

cmd('highlight WinSeperator guibg=None')     -- sleeker separator between splits
cmd('set bg=dark')                           -- set background color
cmd('set clipboard+=unnamedplus')            -- enables copy / pasting to and from external programs
cmd('set cmdheight=1')                       -- cleaner ui by hiding the command-line
cmd('set completeopt=menuone,noselect')      -- configure insert-mode completion
cmd('set confirm')                           -- ask for confirmation instead of failing on actions like ':q', ':e', etc.
cmd('set cursorline')                        -- highlights current line
cmd('set diffopt+=vertical')                 -- prefer vertical diff split for merge conflicts
cmd('set encoding=utf8')                     -- set default encoding standard
cmd('set expandtab')                         -- converts all tabs to spaces on save
cmd('set hidden')                            -- allow switching buffers without saving them
cmd('set ignorecase')                        -- searching ignores case
cmd('set incsearch')                         -- incremental searching
cmd('set laststatus=3')                      -- disable per-split statusline
cmd('set mouse=a')                           -- enable mouse usage
cmd('set nobackup')                          -- disable backup files
cmd('set noshowmode')                        -- disables messages below the tabline
cmd('set noswapfile')                        -- disable swap files
cmd('set nowrap')                            -- disable line wrapping
cmd("let g:tex_flavor='latex'")              -- override tex flavor
cmd('set number')                            -- show numbers on side
cmd('set relativenumber')                    -- set relative line numbering
cmd('set scrolloff=4')                       -- always pad the top / bottom of the buffer by 8 lines when scrolling
cmd('set shiftwidth=2')                      -- enables auto indenting to the same degree of tab lengths
cmd('set showbreak=↪\\ ')                    -- character to show before the continuation of a wrapped line
cmd('set showtabline=2')                     -- always show tab bar
cmd('set signcolumn=yes')                    -- always show signcolumn
cmd('set smartcase')                         -- use case aware search only if search is capitalized
cmd('set tabstop=2')                         -- sets tab length to 2 instead of the default 8
cmd('set termguicolors')                     -- enable 24 bit rgb
cmd('set timeoutlen=250')                    -- make timeout length faster (default: 1000ms)
silent(cmd, 'colorscheme ' .. colorscheme)   -- set colorscheme
vim.opt.list = true                          -- enable list characters
vim.opt.listchars = {
  -- eol = '⤶',
  extends = '⟩',
  nbsp = '␣',
  precedes = '⟨',
  tab = '→\\ ',
  trail = '•',
}

-- enable alpha
-- cmd('autocmd BufRead,BufNew,BufEnter * highlight Normal guibg=none')

-- disables auto-comment continuations for .py files (some filetypes have their format-options overwritten by ftplugins)
cmd('autocmd BufRead,BufNew,BufEnter *.py* set formatoptions-=cro shiftwidth=4 tabstop=4 expandtab')

-- run a configurable autocmd from the parent folder of 'file' when 'file' is written to
local function action_on_write(file, command)
  if not command then
    local parent_folder = file:match('.*/')
    command = '!cd ' .. parent_folder .. '; sudo make install'
  end
  cmd('autocmd BufWritePost ' .. file .. ' ' .. command)
end

-- recompile suckless / xresource configs on write
action_on_write('~/.config/dwm/config.h')
action_on_write('~/.config/st/config.h')
action_on_write('~/.config/dmenu/config.h')
action_on_write('~/.config/slock/config.h')
action_on_write(
  '~/.config/dwmblocks/config.h',
  '!cd ~/.config/dwmblocks/; sudo make install; kill $(pidof -s dwmblocks) >/dev/null; dwmblocks &'
)
action_on_write(
  '~/.xresources',
  'autocmd BufWritePost ~/.xresources !xrdb -DPYWAL_="<$HOME/.cache/wal/colors.Xresources>" -merge ~/.xresources'
)
