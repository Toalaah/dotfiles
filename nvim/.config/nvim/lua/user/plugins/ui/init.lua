return {
  {
    'rcarriga/nvim-notify',
    event = 'VeryLazy',
    config = function()
      local notify = require 'notify'
      notify.setup {
        max_width = function() return math.ceil(vim.api.nvim_win_get_width(0) / 4) end,
        max_height = function() return math.ceil(vim.api.nvim_win_get_height(0) / 6) end,
        fps = 60,
        timeout = 1500,
      }
      vim.notify = notify
    end,
  },
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    config = function()
      require('dressing').setup {
        input = {
          override = function(conf)
            conf.col = -1
            conf.row = 0
            return conf
          end,
        },
      }
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'VeryLazy',
    config = function()
      require('indent_blankline').setup {
        enabled = false, -- default to off, can still be manually turned on after
        use_treesitter = true,
        space_char_blankline = ' ',
        show_current_context = true,
        show_current_context_start = true,
        show_end_of_line = true,
      }
    end,
  },
  {
    'folke/todo-comments.nvim',
    event = 'VeryLazy',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      require('todo-comments').setup {
        signs = false,
        gui_style = {
          fg = 'BOLD',
          bg = 'NONE',
        },
        highlight = {
          keyword = 'fg',
          multiline = false,
        },
      }
    end,
  },
}
