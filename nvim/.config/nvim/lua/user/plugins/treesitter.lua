return {
  'nvim-treesitter/nvim-treesitter',
  event = 'BufReadPost',
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        'bash',
        'go',
        'help',
        'javascript',
        'lua',
        'org',
        'rust',
        'typescript',
        'vim',
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'org' },
      },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<CR>',
          node_incremental = '<CR>',
          scope_incremental = '<S-CR>',
          node_decremental = '<BS>',
        },
      },
    }
  end,
  build = function() require('nvim-treesitter.install').update { with_sync = true }() end,
  dependencies = {
    { 'p00f/nvim-ts-rainbow', enabled = false },
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
}
