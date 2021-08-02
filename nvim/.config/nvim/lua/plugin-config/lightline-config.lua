vim.g.lightline = (
{ 
  colorscheme = 'jellybeans',
  active = {
    left = {
      {
        'mode',
        'paste'
      },
      {
        'gitbranch',
        'readonly',
        'filename',
        'modified'
      }
    }
  },
  component_function = {
    gitbranch = 'FugitiveHead'
  },
  tabline = {
    left = {
      {
        'buffers'
      }
    },
    right = {
      {
        'close'
      }
    }
  },
  component_expand = {
    buffers = 'lightline#bufferline#buffers'
  },
  component_type = {
    buffers = 'tabsel'
  }
})
