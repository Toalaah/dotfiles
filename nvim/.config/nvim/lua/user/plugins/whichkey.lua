return {
  'folke/which-key.nvim',
  cmd = 'WhichKey',
  keys = { '<leader>', 'z' },
  init = function()
    local nnoremap = require('util.keybindings').nnoremap
    nnoremap('?', '<Cmd>WhichKey<CR>', 'Keybindings help')
  end,
  config = function()
    local wk = require 'which-key'
    wk.setup {
      plugins = {
        spelling = {
          enabled = true,
        },
      },
    }
    wk.register { ['<leader>f'] = { name = '[F]ile' } }
    wk.register { ['<leader>l'] = { name = '[L]SP' } }
    wk.register { ['<leader>g'] = { name = '[G]it', ['h'] = { name = '[H]unk' } } }
    wk.register { ['<leader>t'] = { name = '[T]erm' } }
    wk.register { ['<leader>s'] = { name = '[S]et' } }
  end,
}
