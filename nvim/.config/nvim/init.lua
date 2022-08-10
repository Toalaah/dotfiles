-- check for cached lua modules via impatient.nvim
require('cache')
-- general preferences and options
require('preferences')
-- load and initialize plugins
require('plugins')
-- attempt to load colorscheme, use builtin colorscheme as fallback
require('colorscheme')
-- source autocommands
require('autocmds')
