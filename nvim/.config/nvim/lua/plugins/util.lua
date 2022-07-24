local M = {}

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

---@param plugin_name string
---@return string
M.config_require_path = function(plugin_name)
  local c = M.normalize(plugin_name)
  return 'plugins.' .. c .. '.' .. c .. '-config'
end

---@return boolean
M.is_installed = function(plugin_name)
  -- strips everything up to first occurrence of '/' (including '/')
  local config_name = string.match(plugin_name, '/(.+)')
  local path = vim.fn.stdpath('data') .. '/site/pack/packer/start/' .. config_name
  return M.exists(path)
end

M.config_exists = function(plugin_name)
  local path = vim.fn.stdpath('config') .. '/lua/plugins/' .. M.normalize(plugin_name)
  return M.exists(path)
end

---@param plugin_name string
---@return table
M.plugin = function(plugin_name)
  local plug_opts = { plugin_name }

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
