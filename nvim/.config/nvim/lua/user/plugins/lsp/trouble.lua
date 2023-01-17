return {
  'folke/trouble.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  cmd = {
    'Trouble',
    'TroubleClose',
    'TroubleToggle',
    'TroubleRefresh',
  },
  config = function()
    require('trouble').setup {}
    -- require('user.autocmds').create_autocmd {
    --   event = 'FileType',
    --   pattern = 'Trouble',
    --   callback = function(args)
    --     local bufnr = args.buf
    --     vim.keymap.set('n', '<CR>', '<Cmd>TroubleClose<CR>', { noremap = true, buffer = bufnr })
    --   end,
    --   desc = 'Auto-close trouble window on selection via <CR>',
    -- }
  end,
}
