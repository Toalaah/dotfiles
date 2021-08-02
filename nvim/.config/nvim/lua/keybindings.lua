vim.g.mapleader = " " -- map leader to space

-- TODO: hi

-- TODO: add nnoremap to some functions
-- miscellaneous
vim.api.nvim_set_keymap("n", "<C-a>", "ggVG<c-$>", {}) -- select all

-- fuzzy finding and file navigation
vim.api.nvim_set_keymap("n", "<C-p>",   ":Telescope find_files<CR>", {}) 
vim.api.nvim_set_keymap("n", "<Leader>g",   ":Telescope live_grep<CR>", {}) 

-- buffer navigation
vim.api.nvim_set_keymap("n", "<Tab>",   ":bnext<CR>", { silent = true } ) 
vim.api.nvim_set_keymap("n", "<S-Tab>", ":bprev<CR>",{ silent = true }) 

-- commenting
vim.api.nvim_set_keymap("n", "<leader>/", "<Plug>kommentary_line_default", {})
vim.api.nvim_set_keymap("v", "<leader>/", "<Plug>kommentary_visual_default", {})

-- virtual line navigation
vim.api.nvim_set_keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.api.nvim_set_keymap("v", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.api.nvim_set_keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.api.nvim_set_keymap("v", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.api.nvim_set_keymap("n", "$", "v:count == 0 ? 'g$' : '$'", { expr = true, silent = true })
vim.api.nvim_set_keymap("v", "$", "v:count == 0 ? 'g$' : '$'", { expr = true, silent = true })
vim.api.nvim_set_keymap("n", "^", "v:count == 0 ? 'g^' : '^'", { expr = true, silent = true })
vim.api.nvim_set_keymap("v", "^", "v:count == 0 ? 'g^' : '^'", { expr = true, silent = true })

-- indentation in visual mode
vim.api.nvim_set_keymap("v" , "<", "<gv", { noremap = true })
vim.api.nvim_set_keymap("v" , ">", ">gv", { noremap = true })

