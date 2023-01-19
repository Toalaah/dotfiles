return {
  'akinsho/toggleterm.nvim',
  cmd = { 'ToggleTerm', 'ToggleTermToggleAll' },
  init = function()
    local nnoremap = require('util.keybindings').nnoremap
    nnoremap('<leader>tv', '<Cmd>ToggleTerm direction=vertical<CR>', 'Terminal (vertical split)')
    nnoremap('<leader>ts', '<Cmd>ToggleTerm<CR>', 'Terminal (horizontal split)')
    local function set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    end

    vim.api.nvim_create_autocmd('TermOpen', { pattern = 'term://*', callback = set_terminal_keymaps })
  end,
  config = function()
    require('toggleterm').setup {
      size = function(term)
        if term.direction == 'horizontal' then
          return 15
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.4
        end
      end,
    }
    require('util.keybindings').nnoremap('<leader>tt', '<Cmd>ToggleTermToggleAll<CR>', 'Toggle all Terminals')
  end,
}
