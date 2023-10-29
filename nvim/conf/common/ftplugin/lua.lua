vim.keymap.set(
  'n',
  '<leader>R',
  require('util').reload_module,
  {
    buffer = true,
    desc = 'Reload lua module',
  }
)
