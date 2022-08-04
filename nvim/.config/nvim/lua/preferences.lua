-- stylua: ignore
local options = {
  backup = false,                   -- disable backup files
  bg = 'dark',
  clipboard = 'unnamedplus',        -- enables copy / pasting to and from external programs
  cmdheight = 1,
  completeopt = 'menuone,noselect', -- configure insert-mode completion
  confirm = true,                   -- ask for confirmation instead of failing on actions like ':q', ':e', etc.
  cursorline = true,                -- highlights current line
  diffopt = 'vertical',             -- prefer vertical diff split for merge conflicts
  encoding = 'utf8',                -- set default encoding standard
  expandtab = true,                 -- converts all tabs to spaces on save
  hidden = true,                    -- allow switching buffers without saving them
  ignorecase = true,                -- searching ignores case
  incsearch = true,                 -- incremental searching
  laststatus = 3,                   -- disable per-split statusline
  list = true,                      -- enable list characters
  listchars = {
    -- eol = '⤶',
    extends = '⟩',
    nbsp = '␣',
    precedes = '⟨',
    tab = '→\\ ',
    trail = '•',
  },
  mouse = 'a',                      -- enable mouse usage
  number = true,                    -- show numbers on side
  relativenumber = true,            -- set relative line numbering
  scrolloff = 4,                    -- always pad the top / bottom of the buffer by 8 lines when scrolling
  shiftwidth = 2,                   -- enables auto indenting to the same degree of tab lengths
  showbreak = '↪',                  -- character to show before the continuation of a wrapped line
  showmode = false,                 -- disables messages below the tabline
  showtabline = 0,                  -- never show tab bar
  signcolumn = 'yes',               -- always show signcolumn
  smartcase = true,                 -- use case aware search only if search is capitalized
  swapfile = false,                 -- disable swap files
  tabstop = 2,                      -- sets tab length to 2 instead of the default 8
  termguicolors = true,             -- enable 24 bit RGB
  timeoutlen = 200,                 -- make timeout length faster (default: 1000ms)
  wrap = false,                     -- disable line wrapping
}

local variables = {
  -- override default latex flavor (default: 'tex')
  tex_flavor = 'latex',
}

for option, value in pairs(options) do
  vim.opt[option] = value
end

for option, value in pairs(variables) do
  vim.g[option] = value
end

-- Custom highlights
vim.api.nvim_set_hl(0, 'WinSeperator', { bg = 'None' }) -- sleeker separator between splits
