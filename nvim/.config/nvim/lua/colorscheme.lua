require('nvim-tundra').setup({
  transparent_background = false,
  syntax = {
    comments = { bold = false, italic = true },
  },
})

vim.opt.background = 'dark'
local colorscheme = 'tundra'

-- fix dark blametext on dark background
vim.defer_fn(function() vim.cmd [[ highlight GitSignsCurrentLineBlame guifg='#374151' ]] end, 0)

local ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not ok then
  vim.notify('Warning: unable to load colorscheme', vim.log.levels.WARN)
  vim.cmd([[colorscheme slate]])
end
