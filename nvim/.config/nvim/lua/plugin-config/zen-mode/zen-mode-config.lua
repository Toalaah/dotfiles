require('zen-mode').setup({
  window = {
    width = 1,
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
    gitsigns = { enabled = true },
    tmux = { enabled = true },
  },
})
