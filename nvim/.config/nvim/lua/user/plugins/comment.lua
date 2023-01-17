return {
  'numToStr/Comment.nvim',
  keys = {
    'gc',
    'gb',
    -- load plugin on visual mode enter
    'v',
    'V',
    '<C-v>',
  },
  config = function()
    require('Comment').setup {
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    }
  end,
}
