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
    separator = '→ ',
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
    h = { '<Cmd>split<CR>', 'Create horizontal split' },
  },
}, opts)

-- lsp mappings
wk.register({

  ['<leader>l'] = {
    name = '+LSP',
    a = { '<Cmd>Telescope lsp_code_actions<CR>', 'Code action' },
    d = { '<Cmd>lua vim.lsp.buf.definition()<CR>', 'Goto definition' },
    D = { '<Cmd>lua vim.lsp.buf.declaration()<CR>', 'Goto declaration' },
    i = { '<Cmd>TroubleToggle lsp_implementations<CR>', 'Goto implementation' },
    I = { '<Cmd>LspInfo<CR>', 'LSP info' },
    S = { '<Cmd>LspInstallInfo<CR>', 'Installed LSP servers' },
    r = { '<Cmd>TroubleToggle lsp_references<CR>', 'Goto references' },
    t = { '<Cmd>TodoQuickFix<CR>', 'View all TODOs' },
    T = { '<Cmd>TroubleToggle lsp_type_definitions<CR>', 'Goto type definition' },
    R = { '<Cmd>lua require"renamer".rename()<CR>', 'Rename variable' },
    x = { '<Cmd>lua vim.diagnostic.open_float()<CR>', 'Show diagnostics' },
    X = { '<Cmd>TroubleToggle document_diagnostics<CR>', 'Show diagnostics' },
  },
}, opts)

wk.register({
  ['<leader>l'] = {
    a = { '<Cmd>Telescope lsp_range_code_actions<CR>', 'Code action' },
  },
}, { mode = 'v', noremap = true })

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

-- quickfix mappings (normal mode)

wk.register({
  ['<C-q>'] = {
    name = '+Quickfix',
    ['q'] = { '<Cmd>lua require"util".toggle_qf_list()<CR>', 'Toggle quick-fix list' },
    ['c'] = { '<Cmd>lua require"util".clear_qf_list()<CR>', 'Clear quick-fix list' },
    ['e'] = { '<Cmd>lua require"util".exec_qf_list()<CR>', 'Exec command for all qf entries' },
    ['j'] = { '<Cmd>cnext<CR>', 'Go to next entry in quickfix list' },
    ['k'] = { '<Cmd>cprev<CR>', 'Go to prev entry in quickfix list' },
  },
})
-- groupless mappings (normal mode)
wk.register({
  -- miscellaneous
  ['<leader><leader>'] = { '<C-^>', 'Switch to previous buffer' },
  ['K'] = { '<Cmd>lua vim.lsp.buf.hover()<CR>', 'Hover' },
  ['<leader>k'] = { '<Cmd>lua require"telescope".extensions.flutter.commands()<CR>', 'Flutter tools' },
  ['Q'] = { '<Cmd>q<CR>', 'Exit' },
  ['Y'] = { 'y$', 'Yank to end of line' },
  ['<C-c>'] = { '<Cmd>bd<CR>', 'Close buffer' },
  ['<leader>A'] = { 'ggVG', 'Select all' },
  ['<C-s>'] = { '<Cmd>w<CR>', 'Save file' },
  ['?'] = { '<Cmd>WhichKey<CR>', 'Show which-key menu' },
  ['<leader>/'] = { '<Cmd> lua require("Comment.api").toggle_current_linewise()<CR>', 'Comment line' },
  ['<leader>p'] = { '<Cmd>FormatWrite<CR>', 'Format and save current file' },
  ['<leader>m'] = { '<Cmd>make<CR>', 'Make' },
  ['<leader>M'] = { '<Cmd>lua require"telescope.builtin".man_pages()<CR>', 'View man-pages' },
  ['<leader>H'] = { '<Cmd>lua require"telescope.builtin".help_tags()<CR>', 'View help tags' },

  -- toggleable settings
  ['<leader>z'] = {
    "<Cmd>lua require('zen-mode').toggle()<CR>",
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
    '<Cmd>lua require"telescope.builtin".find_files()<CR>',
    'Search files',
  },
  ['<C-n>'] = { '<Cmd>NvimTreeToggle<CR>', 'File explorer' },
  ['<Tab>'] = { '<Cmd>bnext<CR>', 'Next buffer' },
  ['<S-Tab>'] = { '<Cmd>bprev<CR>', 'Previous buffer' },

  -- move blocks of text up / down
  ['<A-j>'] = { '<Esc>:m .+1<CR>==', 'Move text-block down' },
  ['<A-k>'] = { '<Esc>:m .-2<CR>==', 'Move text-block up' },

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
  -- move blocks of text up / down
  ['<A-j>'] = { '<Esc>:m .+1<CR>==gi', 'Move text-block down' },
  ['<A-k>'] = { '<Esc>:m .-2<CR>==gi', 'Move text-block up' },
}, { mode = 'i', noremap = true })

-- groupless matchings (visual mode)
wk.register({
  ['*'] = { "y/\\V<C-R>=escape(@\",'/\\')<CR><CR>", 'Search for selected text' },
  ['<'] = { '<gv', 'Increase indent level' },
  ['>'] = { '>gv', 'Decrease indent level' },
  ['<leader>/'] = { '<Cmd>lua require("Comment.api").call("toggle_linewise_op")<CR>g@', 'Comment line range' },
  -- move blocks of text up / down
  ['<A-j>'] = { ":m '>+1<CR>gv=gv", 'Move text-block down' },
  ['<A-k>'] = { ":m '<-2<CR>gv=gv", 'Move text-block up' },
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
