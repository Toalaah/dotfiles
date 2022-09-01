require('Comment').setup({
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
  toggler = {
    -- Line-wise comment toggle keymap
    line = 'gcc',
    -- Block-wise comment toggle keymap
    block = 'gbc',
  },

  opleader = {
    -- Line-comment keymap
    line = 'gc',
    -- Block-comment keymap
    block = 'gb',
  },

  extra = {
    above = 'gcO',
    below = 'gco',
    eol = 'gcA',
  },

  mappings = {
    -- Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
    basic = true,
    -- Extra mappings (`gco`, `gcO`, `gcA`)
    extra = true,
  },
})
