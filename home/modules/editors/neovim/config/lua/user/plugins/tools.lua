return {
  {
    'mbbill/undotree',
    cmd = {
      'UndotreeHide',
      'UndotreeShow',
      'UndotreeFocus',
      'UndotreeToggle',
    },
  },
  { 'dstein64/vim-startuptime', cmd = 'StartupTime' },
  {
    'famiu/bufdelete.nvim',
    cmd = { 'Bdelete', 'Bwipeout' },
  },
  {
    'alexghergh/nvim-tmux-navigation',
    cmd = {
      'NvimTmuxNavigateLeft',
      'NvimTmuxNavigateDown',
      'NvimTmuxNavigateUp',
      'NvimTmuxNavigateRight',
    },
    opts = {
      disable_when_zoomed = true,
    },
    keys = {
      { '<C-h>', '<Cmd>NvimTmuxNavigateLeft<CR>', desc = 'Navigate left' },
      { '<C-j>', '<Cmd>NvimTmuxNavigateDown<CR>', desc = 'Navigate down' },
      { '<C-k>', '<Cmd>NvimTmuxNavigateUp<CR>', desc = 'Navigate up' },
      { '<C-l>', '<Cmd>NvimTmuxNavigateRight<CR>', desc = 'Navigate right' },
    },
  },
  {
    'akinsho/toggleterm.nvim',
    cmd = { 'ToggleTerm', 'ToggleTermToggleAll' },
    init = function()
      local nnoremap = require('util.keybindings').nnoremap
      nnoremap('<leader>tv', '<Cmd>ToggleTerm direction=vertical<CR>', 'Terminal (vertical split)')
      nnoremap('<leader>ts', '<Cmd>ToggleTerm<CR>', 'Terminal (horizontal split)')
      local function set_terminal_keymaps()
        local opts = { buffer = 0 }
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      end

      vim.api.nvim_create_autocmd('TermOpen', { pattern = 'term://*', callback = set_terminal_keymaps })
    end,
    config = function()
      require('toggleterm').setup {
        size = function(term)
          if term.direction == 'horizontal' then
            return 15
          elseif term.direction == 'vertical' then
            return vim.o.columns * 0.4
          end
        end,
      }
      require('util.keybindings').nnoremap('<leader>tt', '<Cmd>ToggleTermToggleAll<CR>', 'Toggle all Terminals')
    end,
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    keys = {
      { '<C-n>', '<Cmd>Neotree focus toggle<CR>', desc = 'File explorer' },
    },
    cmd = 'Neotree',
    opts = {
      filesystem = {
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_hidden = true,
          always_show = { '.gitignored' },
          never_show = { '.DS_Store' },
        },
        renderers = {
          directory = {
            {
              'container',
              content = {
                { 'name', zindex = 10 },
                {
                  'symlink_target',
                  zindex = 10,
                  highlight = 'NeoTreeSymbolicLinkTarget',
                },
              },
            },
          },
        },
      },
    },
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    keys = {
      { '?', '<Cmd>WhichKey<CR>', desc = 'WhichKey' },
    },
    config = function()
      local wk = require 'which-key'
      wk.setup {
        plugins = { spelling = { enabled = true } },
      }
      wk.register { ['<leader>f'] = { name = '[F]ile' } }
      wk.register { ['<leader>l'] = { name = '[L]SP' } }
      wk.register {
        ['<leader>g'] = {
          name = '[G]it',
          ['h'] = { name = '[H]unk' },
          ['c'] = { name = '[C]onflict' },
        },
      }
      wk.register { ['<leader>t'] = { name = '[T]erm' } }
      wk.register { ['<leader>s'] = { name = '[S]et' } }
    end,
  },
}
