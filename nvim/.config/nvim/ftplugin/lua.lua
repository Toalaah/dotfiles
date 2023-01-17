local kb_util = require 'util.keybindings'
local nnomap = kb_util.nnoremap
nnomap('<leader>R', require('util.reload').reload_module, 'Reload lua module')
