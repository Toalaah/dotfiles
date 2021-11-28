require('zen-mode').setup({
  window = {
    options = {
      signcolumn = 'no',
      number = false,
      relativenumber = false,
      cursorline = false,
      cursorcolumn = false,
      foldcolumn = '0',
      list = false,
    },
  },
  plugins = {
    gitsigns = { enabled = false },
    tmux = { enabled = false },
  },
})
