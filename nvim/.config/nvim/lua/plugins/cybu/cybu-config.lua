require('cybu').setup()
vim.keymap.set('n', 'H', '<Plug>(CybuPrev)')
vim.keymap.set('n', 'L', '<Plug>(CybuNext)')
vim.cmd[[highlight CybuFocus guibg=#24283b]]
