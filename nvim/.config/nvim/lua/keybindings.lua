vim.g.mapleader = " "

-- miscellaneous
vim.api.nvim_set_keymap("n", "<C-a>", "ggVG<c-$>", {})              -- select all
vim.api.nvim_set_keymap("n", "<C-c>", ":bd<CR>", { silent = true, noremap=true }) -- close buffer
vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>",  { silent = true }) -- close buffer
vim.api.nvim_set_keymap("i", "<C-s>", "<Esc>:w<CR>a",  { silent = true }) -- close buffer
vim.api.nvim_set_keymap("n", "q:", "<nop>", { silent = true, noremap=true}) -- gets rid of annoying commandline

-- move between splits more comfortably
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w><C-h>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w><C-j>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w><C-k>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w><C-l>", { noremap = true })


-- fuzzy finding and file navigation w/ telescope
vim.api.nvim_set_keymap('n', '<C-p>',
  ':lua require"telescope.builtin".find_files({ hidden = true })<CR>',
  {noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<leader>F',
  ':lua require"telescope.builtin".live_grep()<CR>',
  {noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<leader>f',
  ':lua require"telescope.builtin".current_buffer_fuzzy_find()<CR>',
  {noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<leader>?',
  ':lua require"telescope.builtin".help_tags()<CR>',
  {noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<leader>gb',
  ':lua require"telescope.builtin".git_branches()<CR>',
  {noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<leader>gc',
  ':lua require"telescope.builtin".git_commits()<CR>',
  {noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<leader>gf',
  ':lua require"telescope.builtin".git_files()<CR>',
  {noremap = true, silent = true})

-- buffer navigation
vim.api.nvim_set_keymap("n", "<Tab>",   ":bnext<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<S-Tab>", ":bprev<CR>", { silent = true })

-- commenting
vim.api.nvim_set_keymap("n", "<leader>/", "<Plug>kommentary_line_default",   {})
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

-- file browser
vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", { silent = true })

