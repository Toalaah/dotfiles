vim.g.nvim_tree_side = 'left'
vim.g.nvim_tree_auto_close =1
vim.g.nvim_tree_auto_open = 1
vim.g.nvim_tree_follow = 1
vim.g.nvim_tree_width = 20
vim.g.nvim_tree_icons = {
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

