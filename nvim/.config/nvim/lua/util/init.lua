---@param condition boolean
local function if_then_else(condition, if_true, if_false)
  if condition then return if_true else return if_false end
end

---@return boolean
local function is_qf_buffer(v)
  return vim.api.nvim_buf_is_loaded(v) and (vim.api.nvim_buf_get_option(v, 'buftype') == 'quickfix')
end

---@param state 'open'|'close'
local function toggle_qf_list(state)
  local cmd = 'c' .. state
  vim.api.nvim_command(cmd)
end

local function qf_is_open()
  local buffers = vim.api.nvim_list_bufs()
  for _, v in pairs(buffers) do
    if is_qf_buffer(v) then return true end
  end
  return false
end

---@class Util
local M = {}

M.toggle_sign_column = function()
  local newState = if_then_else(vim.o.signcolumn == 'yes', 'no', 'yes')
  vim.o.signcolumn = newState
end


M.toggle_qf_list = function()
  local newState = if_then_else(qf_is_open(), 'close', 'open')
  toggle_qf_list(newState)
end

-- call f(...) without omitting errors
M.call_silent = function (f, ...)
  pcall(f, ...)
end

return M
