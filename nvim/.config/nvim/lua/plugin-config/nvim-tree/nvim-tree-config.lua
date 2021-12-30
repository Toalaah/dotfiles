require('nvim-tree').setup({
  update_cwd = true,
  tree_side = 'left',
  auto_close = true,
  tree_follow = true,
  tree_width = 20,
  update_to_buf_dir = {
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
  tree_icons = {
    default = '',
    symlink = '',
    git = {
      unstaged = '✗',
      staged = '✓',
      unmerged = '',
      renamed = '➜',
      untracked = '★',
      deleted = '',
      ignored = '◌',
    },
    folder = {
      arrow_open = '',
      arrow_closed = '',
      default = '',
      open = '',
      empty = '',
      empty_open = '',
      symlink = '',
      symlink_open = '',
    },
    lsp = {
      hint = '',
      info = '',
      warning = '',
      error = '',
    },
  },
})
