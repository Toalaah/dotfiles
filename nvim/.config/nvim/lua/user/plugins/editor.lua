return {
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function() require('nvim-autopairs').setup {} end,
  },
  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    config = function()
      require('Comment').setup {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
  },
  {
    'smjonas/inc-rename.nvim',
    event = 'VeryLazy',
    opts = {
      input_buffer_type = "dressing"
    },
  },
  -- {
  --   'kylechui/nvim-surround',
  --   event = 'VeryLazy',
  --   config = function() require('nvim-surround').setup {} end,
  -- },
  -- -- TODO: folds
  -- {
  --   'kevinhwang91/nvim-ufo',
  --   dependencies = 'kevinhwang91/promise-async',
  -- },
}
