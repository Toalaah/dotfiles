return {
  'numToStr/Navigator.nvim',
  cmd = {
    'NavigatorLeft',
    'NavigatorRight',
    'NavigatorUp',
    'NavigatorDown',
    'NavigatorPrevious',
  },
  init = function()
    local nnomap = require('util.keybindings').nnoremap
    nnomap('<C-h>', '<Cmd>NavigatorLeft<CR>', 'Navigate left')
    nnomap('<C-l>', '<Cmd>NavigatorRight<CR>', 'Navigate right')
    nnomap('<C-k>', '<Cmd>NavigatorUp<CR>', 'Navigate up')
    nnomap('<C-j>', '<Cmd>NavigatorDown<CR>', 'Navigate down')
  end,
  config = function() require('Navigator').setup() end,
}
