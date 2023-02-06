return {
  -- notifications
  {
    'rcarriga/nvim-notify',
    event = 'VeryLazy',
    config = function()
      local notify = require 'notify'
      notify.setup {
        max_width = function() return math.ceil(vim.api.nvim_win_get_width(0) / 4) end,
        max_height = function() return math.ceil(vim.api.nvim_win_get_height(0) / 6) end,
        timeout = 1500,
      }
      vim.notify = notify
    end,
  },
  -- Improved UI elements such as inputs, etc.
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    opts = {
      input = {
        override = function(conf)
          conf.col = -1
          conf.row = 0
          return conf
        end,
      },
    },
  },
  -- indentation guidelines
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'VeryLazy',
    opts = {
      enabled = false,
      use_treesitter = true,
      space_char_blankline = ' ',
      show_current_context = true,
      show_current_context_start = true,
      show_end_of_line = true,
    },
  },
  -- highlighting / management of TODO comments
  {
    'folke/todo-comments.nvim',
    event = 'VeryLazy',
    dependencies = 'nvim-lua/plenary.nvim',
    opts = {},
  },
  -- statusline
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    -- TODO: customize statusline
    opts = {},
  },
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    config = function()
      require('bufferline').setup {
        options = {
          indicator = { style = 'none' },
          diagnostics = 'nvim_lsp',
          show_buffer_close_icons = false,
          diagnostics_indicator = function(count, level, _, _)
            local icon = level:match 'error' and ' ' or ' '
            return ' ' .. icon .. count
          end,
          show_close_icon = false,
          always_show_bufferline = false,
          offsets = {
            {
              filetype = 'neo-tree',
              text = 'Project Files',
              text_align = 'left',
              separator = false,
            },
          },
        },
      }
    end,
  },
}
