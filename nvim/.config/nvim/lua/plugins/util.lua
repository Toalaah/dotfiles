---@class plugin_util
local M = {}

---Checks whether a given directory exists.
---@param path string
---@return boolean
M.exists = function(path)
  return vim.fn.empty(vim.fn.glob(path)) <= 0
end

---Normalizes a (GitHub) repository slug to a common format. Everything after the
---first occurrence of '/' is included, up to either the end of the string or the
---first '.'. The entire string is also converted to lowercase.
---
---Examples:
---  someUser/plugin.nvim -> plugin
---  anotherUser/Cool-Plugin -> cool-plugin
---@param plugin_name string
---@return string
M.normalize = function(plugin_name)
  return string.lower(string.match(plugin_name, '/([^%.]+)'))
end

---Returns the require path for a plugin based on the normalized plugin name.
---@param plugin_name string
---@return string
M.config_require_path = function(plugin_name)
  local c = M.normalize(plugin_name)
  return string.format('plugins.%s.%s-config', c, c)
end

---Returns a default plugin specification which can be consumed by Packers
---`use()` function. The configuration file for the specified plugin is
---loaded using `pcall()` in order to catch errors stemming from missing config files.
---@param plugin string|table Either plugin name as GitHub repo slug or table containing plugin name as first entry followed by arbitrary packer-compatible directives.
---@return table
M.plugin = function(plugin)
  local plug_opts, plugin_name
  if type(plugin) == 'table' then
    plug_opts = plugin
  else
    plug_opts = { plugin }
  end
  plugin_name = plug_opts[1]
  -- attempt to require plugin config
  pcall(require, M.config_require_path(plugin_name))
  return plug_opts
end

M.bootstrap_packer = function()
  local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    M.did_bootstrap = vim.fn.system({
      'git',
      'clone',
      '--depth',
      '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path,
    })
    vim.cmd([[packadd packer.nvim]])
  end
end

return M
