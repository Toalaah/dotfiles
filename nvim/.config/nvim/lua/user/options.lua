vim.opt.backup = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.cmdheight = 0
vim.opt.completeopt:append 'menu,menuone,noselect'
vim.cmd [[set spelllang=en_us,de_de ]]
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.diffopt = 'vertical'
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = 'expr'
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.expandtab = true
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.listchars = {
  extends = '⟩',
  nbsp = '␣',
  precedes = '⟨',
  tab = '→\\ ',
  trail = '•',
  -- eol = '↴',
  -- space = '⋅',
}
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.shiftwidth = 2
vim.opt.showbreak = '↪'
vim.opt.showmode = false
vim.opt.showtabline = 0
vim.opt.signcolumn = 'auto:2'
vim.opt.smartcase = true
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.timeoutlen = 250
vim.opt.wrap = false

vim.g.tex_flavor = 'latex'
vim.g.mapleader = ' '

-- prevent loading builtin plugins
for _, plugin in ipairs {
  '2html_plugin',
  'fzf',
  'getscript',
  'getscriptPlugin',
  'gzip',
  'logiPat',
  'matchit',
  'matchparen',
  'netrw',
  'netrwFileHandlers',
  'netrwPlugin',
  'netrwSettings',
  'rrhelper',
  'tar',
  'tarPlugin',
  'vimball',
  'vimballPlugin',
  'zip',
  'zipPlugin',
} do
  vim.g['loaded_' .. plugin] = 1
end
