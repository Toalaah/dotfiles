-- check for cached lua modules
_G.__luacache_config = {
  chunks = {
    enable = true,
    path = vim.fn.stdpath('cache') .. '/luacache_chunks',
  },
  modpaths = {
    enable = true,
    path = vim.fn.stdpath('cache') .. '/luacache_modpaths',
  },
}
pcall(require, 'impatient')
-- general preferences and options
require('preferences')
-- load and initialize plugins
require('plugins')
-- attempt to load colorscheme, use builtin colorscheme as fallback
require('colorscheme')
-- source autocommands
require('autocmds')
