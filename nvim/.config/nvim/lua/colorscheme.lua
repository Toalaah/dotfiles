vim.g.tokyonight_style = 'night'
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { 'qf', 'vista_kind', 'terminal', 'packer' }
local colorscheme = 'tokyonight'

local ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not ok then
  vim.notify('Warning: unable to load colorscheme', vim.log.levels.WARN)
  vim.cmd([[colorscheme slate]])
end
