vim.o.termguicolors = true
local opts = {
  fps = 60,
  max_width = 80,
  max_height = 15,
  timeout = 1500,
  top_down = true,
  render = 'minimal',
  background_colour = '#00FF00',
}
local notify = require('notify')
notify.setup(opts)
vim.notify = notify
