-- plugin sourcing
require('plugin-config.plugins')

-- plugin / lsp configurations
require('plugin-config.lsp-install')
require('plugin-config.lsp-config')
require('plugin-config.lualine-config')
require('plugin-config.bufferline-config')
require('plugin-config.compe-config')
require('plugin-config.startify-config')
require('plugin-config.telescope-config')
require('plugin-config.nvim-tree-config')

-- general preferences, bindings, etc
require('preferences')
require('keybindings')

