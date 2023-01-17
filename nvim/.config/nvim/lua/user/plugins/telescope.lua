local M = {
  'nvim-telescope/telescope.nvim',
  cmd = { 'Telescope' },
  dependencies = { { 'nvim-lua/plenary.nvim' }, { 'nvim-telescope/telescope-file-browser.nvim' } },
}

local keybindings = {
  ['<C-p>'] = { '<Cmd>Telescope find_files<CR>', 'Search project files' },
  ['<leader>ff'] = { '<Cmd>Telescope live_grep<CR>', 'Grep' },
  ['<leader>fr'] = { '<Cmd>Telescope oldfiles<CR>', 'Search recent files' },
  ['<leader>fm'] = { '<Cmd>Telescope man_pages<CR>', 'Man pages' },
  ['<leader>fh'] = { '<Cmd>Telescope help_tags<CR>', 'Help tags' },
  ['<leader>gc'] = { '<Cmd>Telescope git_commits<CR>', 'Git commits' },
  ['<leader>gb'] = { '<Cmd>Telescope git_branches<CR>', 'Git branches' },
  ['<leader>gf'] = { '<Cmd>Telescope git_files<CR>', 'Git files' },
  ['<leader>e'] = { '<Cmd>Telescope file_browser<CR>', 'File Explorer' },
}

M.init = function()
  local nnomap = require('util.keybindings').nnoremap
  for keymap, action in pairs(keybindings) do
    local cmd = action[1]
    local desc = action[2]
    nnomap(keymap, cmd, desc)
  end
end

M.config = function()
  local telescope = require 'telescope'
  telescope.setup {
    extensions = {
      file_browser = {
        theme = 'ivy',
        hijack_netrw = true,
      },
    },
  }
  telescope.load_extension 'file_browser'
end

return M
