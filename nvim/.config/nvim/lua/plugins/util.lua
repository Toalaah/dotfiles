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

---Checks whether a plugin is installed (assumes that packer is being used).
---@param plugin_name string
---@return boolean
M.is_installed = function(plugin_name)
  -- strip everything up to first occurrence of '/' (including '/')
  ---Example:
  ---  someUser/plugin.nvim -> plugin.nvim
  local config_name = string.match(plugin_name, '/(.+)')
  local path = string.format('%s/site/pack/packer/start/%s', vim.fn.stdpath('data'), config_name)
  return M.exists(path)
end

---Checks whether a plugin is installed (assumes that packer is being used).
---@param plugin_name string
---@return boolean
M.config_exists = function(plugin_name)
  local path = string.format('%s/lua/plugins/%s', vim.fn.stdpath('config'), M.normalize(plugin_name))
  return M.exists(path)
end

---Returns a default plugin specification which can be consumed by
---Packer's `use()` function. The configuration file for the specified
---plugin is loaded if and only if said config file is is found and the
---plugin is already installed.
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
  -- attempt to require plugin if config file exists and plugin is installed
  if M.config_exists(plugin_name) and M.is_installed(plugin_name) then
    local req_path = M.config_require_path(plugin_name)
    require(req_path)
  end

  return plug_opts
end

M.bootstrap_packer = function()
  local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  local did_bootstrap = nil
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    did_bootstrap = vim.fn.system({
      'git',
      'clone',
      '--depth',
      '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path,
    })
    vim.cmd('packadd packer.nvim')
  end
  return did_bootstrap
end

return M
