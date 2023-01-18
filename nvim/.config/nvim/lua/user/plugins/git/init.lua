return {
  {
    'akinsho/git-conflict.nvim',
    cmd = {
      'GitConflictChooseOurs',
      'GitConflictChooseTheirs',
      'GitConflictChooseBoth',
      'GitConflictChooseNone',
      'GitConflictNextConflict',
      'GitConflictPrevConflict',
      'GitConflictListQf',
    },
    config = function() require('git-conflict').setup() end,
  },
  {
    'tpope/vim-fugitive',
    cmd = { 'Git' },
    init = function()
      local nnoremap = require('util.keybindings').nnoremap
      nnoremap('<leader>gP', '<Cmd>Git push<CR>', 'Push changes')
      nnoremap('<leader>gS', '<Cmd>Git<CR>', 'Stage changes')
      nnoremap('<leader>gC', '<Cmd>Git commit<CR>', 'Push changes')
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    init = function()
      local nnoremap = require('util.keybindings').nnoremap
      nnoremap('<leader>ghv', '<Cmd>Gitsigns preview_hunk<CR>', 'View hunk')
      nnoremap('<leader>ghp', '<Cmd>Gitsigns prev_hunk<CR><Cmd>Gitsigns preview_hunk<CR>', 'Select prev hunk')
      nnoremap('<leader>ghn', '<Cmd>Gitsigns next_hunk<CR><Cmd>Gitsigns preview_hunk<CR>', 'Select next hunk')
      nnoremap('<leader>ghs', '<Cmd>Gitsigns stage_hunk<CR>', 'Stage hunk')
      nnoremap('<leader>ghr', '<Cmd>Gitsigns reset_hunk<CR>', 'Reset hunk')
    end,
    config = function()
      require('gitsigns').setup {
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol',
          delay = 500,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
      }
    end,
  },
}
