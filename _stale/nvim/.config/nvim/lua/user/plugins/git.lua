return {
  -- handle git conflicts
  {
    'akinsho/git-conflict.nvim',
    event = 'VeryLazy',
    keys = {
      { '<leader>gct', '<Cmd>GitConflictChooseTheirs<CR>', desc = 'Choose theirs' },
      { '<leader>gco', '<Cmd>GitConflictChooseOurs<CR>', desc = 'Choose ours' },
      { '<leader>gcb', '<Cmd>GitConflictChooseBoth<CR>', desc = 'Choose both' },
      { '<leader>gcc', '<Cmd>GitConflictChooseNone<CR>', desc = 'Chose none' },
      { '<leader>gc]', '<Cmd>GitConflictNextConflict<CR>', desc = 'Next conflict' },
      { '<leader>gc[', '<Cmd>GitConflictPrevConflict<CR>', desc = 'Prev conflict' },
      { '<leader>gcq', '<Cmd>GitConflictListQf<CR>', desc = 'Open QF list' },
    },
    opts = { default_mappings = false },
  },
  -- general git functionality
  {
    'tpope/vim-fugitive',
    cmd = { 'Git' },
    keys = {
      { '<leader>gP', '<Cmd>Git push<CR>', desc = 'Push changes' },
      { '<leader>gS', '<Cmd>Git<CR>', desc = 'Stage changes' },
      { '<leader>gC', '<Cmd>Git commit<CR>', desc = 'Commit changes' },
    },
  },
  -- statusline integration
  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    keys = {
      { '<leader>ghv', '<Cmd>Gitsigns preview_hunk<CR>', desc = 'View hunk' },
      { '<leader>ghp', '<Cmd>Gitsigns prev_hunk<CR><Cmd>Gitsigns preview_hunk<CR>', desc = 'Select prev hunk' },
      { '<leader>ghn', '<Cmd>Gitsigns next_hunk<CR><Cmd>Gitsigns preview_hunk<CR>', desc = 'Select next hunk' },
      { '<leader>ghs', '<Cmd>Gitsigns stage_hunk<CR>', desc = 'Stage hunk' },
      { '<leader>ghr', '<Cmd>Gitsigns reset_hunk<CR>', desc = 'Reset hunk' },
    },
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 500,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
    },
  },
}
