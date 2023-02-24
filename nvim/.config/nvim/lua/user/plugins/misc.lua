return {
  { 'elkowar/yuck.vim', ft = 'yuck' },
  { 'tikhomirov/vim-glsl', ft = 'glsl' },
  { 'romainl/vim-cool', event = 'VeryLazy' },
  { 'gpanders/editorconfig.nvim', event = 'BufReadPost' },
  { 'NoahTheDuke/vim-just', ft = 'just' },
  {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    build = ':call mkdp#util#install()',
    config = function() vim.g.mkdp_auto_close = false end,
  },
  { 'ekickx/clipboard-image.nvim', ft = 'markdown' },
  {
    'folke/zen-mode.nvim',
    cmd = { 'ZenMode' },
    keys = {
      { '<leader>sz', '<Cmd>ZenMode<CR>', desc = 'Toggle ZenMode' },
    },
    config = function()
      require('zen-mode').setup {
        window = {
          backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
          width = 1, -- width of the Zen window
          height = 1, -- height of the Zen window
          options = {
            signcolumn = 'no', -- disable signcolumn
            number = false, -- disable number column
            relativenumber = false, -- disable relative numbers
            cursorline = false,
            cursorcolumn = false,
            foldcolumn = '0',
            list = false,
          },
        },
        plugins = {
          twilight = { enabled = true },
          gitsigns = { enabled = false },
          tmux = { enabled = false },
          kitty = { enabled = false },
        },
      }
    end,
  },
}
