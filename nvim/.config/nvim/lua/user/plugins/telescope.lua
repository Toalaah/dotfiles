return {
  'nvim-telescope/telescope.nvim',
  cmd = { 'Telescope' },
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-file-browser.nvim' },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    },
  },
  keys = {
    { '<leader><leader>', '<Cmd>Telescope buffers<CR>', desc = 'Search buffers' },
    { '<C-p>', '<Cmd>Telescope find_files<CR>', desc = 'Search project files' },
    { '<leader>ff', '<Cmd>Telescope live_grep<CR>', desc = 'Grep' },
    { '<leader>fr', '<Cmd>Telescope oldfiles<CR>', desc = 'Search recent files' },
    { '<leader>fm', '<Cmd>Telescope man_pages<CR>', desc = 'Man pages' },
    { '<leader>fh', '<Cmd>Telescope help_tags<CR>', desc = 'Help tags' },
    { '<leader>gb', '<Cmd>Telescope git_branches<CR>', desc = 'Git branches' },
    { '<leader>gf', '<Cmd>Telescope git_files<CR>', desc = 'Git files' },
    { '<leader>e', '<Cmd>Telescope file_browser<CR>', desc = 'File Explorer' },
  },
  opts = {
    pickers = {
      colorscheme = {
        enable_preview = true,
      },
      find_files = {
        theme = 'ivy',
        find_command = {
          'rg',
          '--color=never',
          '--column',
          '--files',
          '--follow',
          '--hidden',
          '--no-heading',
        },
      },
      buffers = { theme = 'ivy' },
    },
    extensions = {
      file_browser = {
        theme = 'ivy',
        hijack_netrw = true,
      },
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = 'smart_case',
      },
    },
  },
  config = function(_, opts)
    local telescope = require 'telescope'
    telescope.setup(opts)
    telescope.load_extension 'fzf'
    telescope.load_extension 'file_browser'
  end,
}
