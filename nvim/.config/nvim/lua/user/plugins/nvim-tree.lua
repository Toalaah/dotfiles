return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  init = function() require('util.keybindings').nnoremap('<C-n>', '<Cmd>NvimTreeToggle<CR>', 'File explorer') end,
  cmd = {
    'NvimTreeOpen',
    'NvimTreeClose',
    'NvimTreeToggle',
  },
  config = function()
    require('nvim-tree').setup {
      filters = {
        dotfiles = false,
        custom = { '.DS_STORE' },
      },
    }
  end,
}
