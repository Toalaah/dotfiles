vim.o.termguicolors = true
local opts = {
  fps = 60,
  max_width = 80,
  max_height = 15,
  timeout = 2500,
  background_color = '#000000',
}
local notify = require('notify')
notify.setup(opts)
vim.notify = notify
