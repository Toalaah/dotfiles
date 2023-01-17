return {
  'folke/zen-mode.nvim',
  cmd = { 'ZenMode' },
  init = function()
    local nnoremap = require('util.keybindings').nnoremap
    nnoremap('<leader>sz', '<Cmd>ZenMode<CR>', 'Toggle ZenMode')
  end,
  config = function()
    require('zen-mode').setup {
      window = {
        backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        width = 1, -- width of the Zen window
        height = 1, -- height of the Zen window
        options = {
          signcolumn = 'no', -- disable signcolumn
          number = false, -- disable number column
          relativenumber = false, -- disable relative numbers
          cursorline = false,
          cursorcolumn = false,
          foldcolumn = '0',
          list = false,
        },
      },
      plugins = {
        twilight = { enabled = true },
        gitsigns = { enabled = false },
        tmux = { enabled = false },
        kitty = { enabled = false },
      },
      on_open = function(_)
        vim.cmd [[
          IndentBlanklineDisable
        ]]
      end,
      on_close = function(_)
        vim.cmd [[
        IndentBlanklineEnable
      ]]
      end,
    }
  end,
}
