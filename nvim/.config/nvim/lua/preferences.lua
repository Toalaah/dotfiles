local cmd = vim.api.nvim_command
cmd('set encoding=utf-8') -- set default encoding standard
cmd('set hidden') -- allow switching buffers without saving them
cmd('set relativenumber') -- set relative line numbering
cmd('set termguicolors') -- enable 24-bit rgb
cmd('set tabstop=2') -- sets tab-length to 2 instead of the default 8
cmd('set shiftwidth=2') -- enables auto-indenting to the same degree of tab-lengths
cmd('set expandtab') -- converts all tabs to spaces on save
cmd('set number') -- show numbers on side
cmd('set noswapfile') -- disable swap-files
cmd('set nobackup') -- disable backup files
cmd('set incsearch') -- incremental searching
cmd('set ignorecase') -- searching ignores case
cmd('set smartcase') -- use case-aware search only if search is capitalized
cmd('set cursorline') -- highlights current line
cmd('set scrolloff=4') -- always pad the top / bottom of the buffer by 8 lines when scrolling
cmd('set signcolumn=yes') -- always show signcolumn
cmd('set nowrap') -- disable line-wrapping
cmd('set noshowmode') -- disables messages below the tabline
cmd('set clipboard+=unnamedplus') -- enables copy / pasting to and from external programs
cmd('set showtabline=2') -- always show tab-bar
cmd('set mouse=a') -- enable mouse usage
cmd('set autoindent') -- auto-indenting
cmd('set bg=dark') -- set background-color
cmd('colorscheme gruvbox') -- set colorscheme
cmd('set timeoutlen=250') -- make timeout length faster (default: 1000ms)
cmd('set list') -- enable list characters
cmd('set showbreak=↪\\ ') -- character to show before the continuation of a wrapped line
cmd('set listchars=tab:→\\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨')
cmd('set completeopt=menuone,noselect')
cmd('set confirm')
cmd('set diffopt+=vertical') -- prefer vertical diff split for merge conflicts

-- enable alpha
-- cmd('autocmd BufRead,BufNew,BufEnter * highlight Normal guibg=none')

-- set filetype to bash for all .sh files
cmd('autocmd BufRead,BufNew,BufEnter *.sh* set syntax=bash')

-- disable error highlighting in json files
cmd('autocmd BufRead,BufNew,BufEnter *.json* hi Error NONE')

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
