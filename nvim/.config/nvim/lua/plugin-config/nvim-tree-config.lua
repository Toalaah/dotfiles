require'nvim-tree'.setup {
  tree_side = 'left',
  tree_auto_close =1,
  tree_auto_open = 1,
  tree_follow = 1,
  tree_width = 20,
  tree_icons = {
       default = '',
       symlink = '',
       git = {
         unstaged = "✗",
         staged = "✓",
         unmerged = "",
         renamed = "➜",
         untracked = "★",
         deleted = "",
         ignored = "◌"
         },
       folder = {
         arrow_open = "",
         arrow_closed = "",
         default = "",
         open = "",
         empty = "",
         empty_open = "",
         symlink = "",
         symlink_open = "",
         },
         lsp = {
           hint = "",
           info = "",
           warning = "",
           error = "",
         }
       }
  }
