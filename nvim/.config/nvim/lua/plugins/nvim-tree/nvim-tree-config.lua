require('nvim-tree').setup({
  update_cwd = true,
  view = {
    width = 15,
    side = 'left',
    signcolumn = 'no',
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
  filters = {
    dotfiles = false,
    custom = { '.DS_STORE' },
  },
})
