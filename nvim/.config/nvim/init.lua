-- plugin sourcing
require('plugin-config/plugins')

-- plugin / lsp configurations
require('plugin-config/language-servers')
require('plugin-config/lualine-config')
require('plugin-config/bufferline-config')
require('plugin-config/compe-config')
require('plugin-config/startify-config')

-- general preferences, bindings, etc
require('preferences')
require('keybindings')
