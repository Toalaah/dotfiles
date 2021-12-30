require('which-key').setup({
  ignore_missing = true,
  plugins = {
    registers = true,
    spelling = {
      enabled = true,
      suggestions = 20,
    },
  },
  window = {
    border = 'single',
  },
  icons = {
    breadcrumb = '»',
    separator = '➜ ',
    group = '+',
  },
})

vim.g.mapleader = ' '
local wk = require('which-key')
local opts = { mode = 'n', noremap = true, silent = true }

-- file navigation mappings
wk.register({

  ['<leader>f'] = {
    name = '+File',
    f = {
      "<Cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find()<CR>",
      'Search in file',
    },
    F = {
      "<Cmd>lua require'telescope.builtin'.live_grep()<CR>",
      'Search in project',
    },
    r = {
      "<Cmd>lua require'telescope.builtin'.oldfiles()<CR>",
      'Open recent File',
    },
    b = {
      "<Cmd>lua require'telescope.builtin'.buffers({previewer = false})<CR>",
      'Search open buffers',
    },
    v = { '<Cmd>vsplit<CR>', 'Create vertical split' },
    s = { '<Cmd>vsplit<CR>', 'Create horizontal split' },
  },
}, opts)

-- lsp mappings
wk.register({

  ['<leader>l'] = {
    name = '+LSP',
    a = { '<Cmd>Telescope lsp_code_actions<CR>', 'Code action' },
    d = { '<Cmd>lua vim.lsp.buf.definition()<CR>', 'Goto definition' },
    D = { '<Cmd>lua vim.lsp.buf.declaration()<CR>', 'Goto declaration' },
    k = { '<Cmd>lua vim.lsp.buf.hover()<CR>', 'Hover' },
    i = { '<Cmd>lua vim.lsp.buf.implementation()<CR>', 'Goto implementation' },
    I = { '<Cmd>LspInfo<CR>', 'LSP info' },
    S = { '<Cmd>LspInstallInfo<CR>', 'Installed LSP servers' },
    r = { '<Cmd>lua vim.lsp.buf.references()<CR>', 'Goto references' },
    R = { '<Cmd>lua require"renamer".rename()<CR>', 'Rename variable' },
    x = { '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', 'Show diagnostics' },
  },
}, opts)

-- terminal mappings
wk.register({

  ['<leader>t'] = {
    name = '+Terminal',
    g = { '<Cmd>FloatermNew lazygit<CR>', 'Git' },
    d = { '<Cmd>FloatermNew lazydocker<CR>', 'Docker' },
    p = { '<Cmd>FloatermNew python3<CR>', 'Python REPL' },
    n = { '<Cmd>FloatermNew node<CR>', 'Node REPL' },
    t = { '<Cmd>FloatermToggle<CR>', 'Toggle' },
    m = { '<Cmd>FloatermNew --wintype=split --height=10<CR>', 'Split' },
  },

  ['<Esc>'] = {
    '<C-Bslash><C-n><Cmd>FloatermToggle<CR>',
    'Hide floating terminal',
    mode = 't',
  },
}, opts)

-- git mappings
wk.register({

  ['<leader>g'] = {
    name = '+Git',
    c = { '<Cmd>lua require"telescope.builtin".git_commits()<CR>', 'Commits' },
    b = { '<Cmd>lua require"telescope.builtin".git_branches()<CR>', 'Branches' },
    f = { '<Cmd>lua require"telescope.builtin".git_files()<CR>', 'Files' },
    S = { '<Cmd>Git<CR>', 'Git status' },
    C = { '<Cmd>Git commit<CR>', 'Commit changes' },
    P = { '<Cmd>Git push<CR>', 'Push changes' },
    s = { '<Cmd>Gitsigns toggle_signs<CR>', 'Toggle signs' },
    t = { '<Cmd>lua require"util".toggleSignColumn()<CR>', 'Toggle signcolumn' },
    l = { '<Cmd>Gitsigns toggle_linehl<CR>', 'Toggle changes highlighting' },
    w = { '<Cmd>Gitsigns toggle_word_diff<CR>', 'Toggle word diff' },
    ['d'] = {
      name = '+Diff',
      m = { '<Cmd>Gdiffsplit!<CR>', 'Merge conflict split' },
      h = { '<Cmd>diffget //2<CR>', 'Choose target (left)' },
      l = { '<Cmd>diffget //3<CR>', 'Choose merge parent (right)' },
    },
    ['h'] = {
      name = '+Hunk',
      v = { '<Cmd>Gitsigns preview_hunk<CR>', 'View hunk' },
      p = {
        '<Cmd>Gitsigns prev_hunk<CR><Cmd>Gitsigns preview_hunk<CR>',
        'Select prev hunk',
      },
      n = {
        '<Cmd>Gitsigns next_hunk<CR><Cmd>Gitsigns preview_hunk<CR>',
        'Select next hunk',
      },
      s = { '<Cmd>Gitsigns stage_hunk<CR>', 'Stage hunk' },
      r = { '<Cmd>Gitsigns reset_hunk<CR>', 'Reset hunk' },
    },
  },
}, opts)

-- groupless mappings (normal mode)
wk.register({

  -- miscellaneous
  ['Q'] = { '<Cmd>q<CR>', 'Exit' },
  ['Y'] = { 'y$', 'Yank to end of line' },
  ['<C-c>'] = { '<Cmd>bd<CR>', 'Close buffer' },
  ['<C-a>'] = { 'ggVG', 'Select all' },
  ['<C-s>'] = { '<Cmd>w<CR>', 'Save file' },
  ['?'] = { '<Cmd>WhichKey<CR>', 'Show which-key menu' },
  ['<leader>/'] = { '<Cmd> lua require("Comment.api").toggle_current_linewise()<CR>', 'Comment line' },
  ['<leader>p'] = { '<Cmd>Format<CR>', 'Format current file' },
  ['<leader>m'] = { '<Cmd>make<CR>', 'Make' },
  ['<leader>M'] = { '<Cmd>lua require"telescope.builtin".man_pages()<CR>', 'View man-pages' },
  ['<leader>H'] = { '<Cmd>lua require"telescope.builtin".help_tags()<CR>', 'View help tags' },

  -- toggleable settings
  ['<leader>z'] = {
    "<Cmd>lua require('zen-mode').toggle({window = {width = .85}})<CR>",
    'Toggle zen mode',
  },
  ['<leader>s'] = {
    name = '+Spelling',
    ['t'] = { '<Cmd>set spell!<CR>', 'Toggle spell-checker' },
    ['s'] = { 'z=', 'Suggest word' },
  },
  ['<leader>n'] = {
    '<Cmd>set number! relativenumber!<CR>',
    'Toggle line numbers',
  },
  ['<leader>r'] = { '<Cmd>set cursorline!<CR>', 'Toggle cursorline' },
  ['<leader>w'] = { '<Cmd>set wrap!<CR>', 'Toggle line-wrapping' },

  -- file / buffer navigation
  ['<C-p>'] = {
    '<Cmd>lua require"telescope.builtin".find_files({ hidden=true, no_ignore=true, previewer = false })<CR>',
    'Search files',
  },
  ['<C-n>'] = { '<Cmd>NvimTreeToggle<CR>', 'File explorer' },
  ['<Tab>'] = { '<Cmd>bnext<CR>', 'Next buffer' },
  ['<S-Tab>'] = { '<Cmd>bprev<CR>', 'Previous buffer' },

  -- split navigaton
  ['<C-h>'] = { '<C-w><C-h>', 'Select left split' },
  ['<C-j>'] = { '<C-w><C-j>', 'Select lower split' },
  ['<C-k>'] = { '<C-w><C-k>', 'Select upper split' },
  ['<C-l>'] = { '<C-w><C-l>', 'Select right split' },

  -- virtual line navigation
  ['j'] = { "v:count == 0 ? 'gj' : 'j'", 'Down', expr = true, silent = true },
  ['k'] = { "v:count == 0 ? 'gk' : 'k'", 'Up', expr = true, silent = true },
  ['$'] = {
    "v:count == 0 ? 'g$' : '$'",
    'Move to end of line',
    expr = true,
    silent = true,
  },
  ['^'] = {
    "v:count == 0 ? 'g^' : '^'",
    'Move to start of line',
    expr = true,
    silent = true,
  },
}, opts)

-- groupless matchings (insert mode)
wk.register({
  ['<C-s>'] = { '<Esc><Cmd>w<CR>a', 'Save file' },
}, { mode = 'i', noremap = true })

-- groupless matchings (visual mode)
wk.register({
  ['<'] = { '<gv', 'Increase indent level' },
  ['>'] = { '>gv', 'Decrease indent level' },
  ['<leader>/'] = { '<Cmd>lua require("Comment.api").call("toggle_linewise_op")<CR>g@', 'Comment line range' },

  -- virtual line navigation
  ['j'] = { "v:count == 0 ? 'gj' : 'j'", 'Down', expr = true, silent = true },
  ['k'] = { "v:count == 0 ? 'gk' : 'k'", 'Up', expr = true, silent = true },
  ['$'] = {
    "v:count == 0 ? 'g$' : '$'",
    'Move to end of line',
    expr = true,
    silent = true,
  },
  ['^'] = {
    "v:count == 0 ? 'g^' : '^'",
    'Move to start of line',
    expr = true,
    silent = true,
  },
}, { mode = 'v', noremap = true })
