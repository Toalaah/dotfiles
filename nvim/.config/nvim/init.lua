-- plugin sourcing
require('plugin-config.plugins')

-- plugin / lsp configurations
require('plugin-config.lsp-installer')
require('plugin-config.lualine-config')
require('plugin-config.bufferline-config')
require('plugin-config.cmp-config')
require('plugin-config.startify-config')
require('plugin-config.telescope-config')
require('plugin-config.nvim-tree-config')
require("plugin-config.flutter-tools-config")

-- general preferences, bindings, etc
require('preferences')
require('keybindings')

