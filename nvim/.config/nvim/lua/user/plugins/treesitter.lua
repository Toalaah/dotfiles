return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = 'BufReadPost',
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    build = function() require('nvim-treesitter.install').update { with_sync = true }() end,
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'bash',
          'go',
          'help',
          'javascript',
          'lua',
          'rust',
          'typescript',
          'vim',
        },
        highlight = { enable = true },
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<CR>',
            node_incremental = '<CR>',
            node_decremental = '<BS>',
          },
        },
      }
    end,
  },
}
