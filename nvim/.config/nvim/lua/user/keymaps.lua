local kb_util = require 'util.keybindings'
local nnomap = kb_util.nnoremap
local inomap = kb_util.inoremap
local vnomap = kb_util.vnoremap

-- various toggles and quick-actions
nnomap('<leader>m', '<Cmd>make<CR>', 'Make')
nnomap('<leader>sc', '<Cmd>set cursorline!<CR>', 'Toggle cursorline')
nnomap('<leader>sw', '<Cmd>set wrap!<CR>', 'Toggle line-wrapping')
nnomap('<leader>ss', '<Cmd>set spell!<CR>', 'Toggle spell-checker')
nnomap('<leader>sn', '<Cmd>set number! relativenumber!<CR>', 'Toggle line numbers')
-- center cursor between jumps
nnomap('<C-d>', '<C-d>zz', 'Jump down')
nnomap('<C-u>', '<C-u>zz', 'Jump up')
nnomap('n', 'nzz', 'Next match')
nnomap('N', 'Nzz', 'Previous match')
-- qol bindings
nnomap('Y', 'y$', 'Yank to end of line')
-- virtual line helpers
nnomap('j', "v:count == 0 ? 'gj' : 'j'", 'Move down', { expr = true, silent = true })
nnomap('k', "v:count == 0 ? 'gk' : 'k'", 'Move up', { expr = true, silent = true })
nnomap('$', "v:count == 0 ? 'g$' : '$'", 'Move to end of line', { expr = true, silent = true })
nnomap('^', "v:count == 0 ? 'g^' : '^'", 'Move to beginning of line', { expr = true, silent = true })
-- same thing but for visual mode
vnomap('j', "v:count == 0 ? 'gj' : 'j'", 'Move down', { expr = true, silent = true })
vnomap('k', "v:count == 0 ? 'gk' : 'k'", 'Move up', { expr = true, silent = true })
vnomap('$', "v:count == 0 ? 'g$' : '$'", 'Move to end of line', { expr = true, silent = true })
vnomap('^', "v:count == 0 ? 'g^' : '^'", 'Move to beginning of line', { expr = true, silent = true })
-- buffer bindings
nnomap('<C-c>', 'bd', 'Close buffer')
nnomap('<Tab>', '<Cmd>bnext<CR>', 'Next buffer')
nnomap('<S-Tab>', '<Cmd>bprev<CR>', 'Previous buffer')
-- move line up or down
nnomap('<A-j>', '<Esc>:m .+1<CR>==', 'Move line down')
nnomap('<A-k>', '<Esc>:m .-2<CR>==', 'Move line up')
-- same thing but for insert mode
inomap('<A-j>', '<Esc>:m .+1<CR>==gi', 'Move line down')
inomap('<A-k>', '<Esc>:m .-2<CR>==gi', 'Move line up')
-- same thing but for visual select mode
vnomap('<A-j>', ":m '>+1<CR>gv=gv", 'Move text-block down')
vnomap('<A-k>', ":m '<-2<CR>gv=gv", 'Move text-block up')
-- misc visual mode qol bindings
vnomap('*', "y/\\V<C-R>=escape(@\",'/\\')<CR><CR>", 'Search for selected text')
vnomap('<', '<gv', 'Increase indent level')
vnomap('>', '>gv', 'Decrease indent level')
