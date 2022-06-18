---@param condition boolean
local function if_then_else(condition, if_true, if_false)
  if condition then
    return if_true
  else
    return if_false
  end
end

---@return boolean
local function is_qf_buffer(v)
  return vim.api.nvim_buf_is_loaded(v) and (vim.api.nvim_buf_get_option(v, 'buftype') == 'quickfix')
end

---@param buf_nr number buffer-id of the quickfix list
---@param state 'open'|'close' action to take on qf list
local function toggle_qf_list(buf_nr, state)
  -- unload buffer if it is open
  if state == 'close' then
    local cmd = 'bunload ' .. buf_nr
    vim.api.nvim_command(cmd)
  end
  local cmd = 'c' .. state
  vim.api.nvim_command(cmd)
end

local function qf_is_open()
  local buffers = vim.api.nvim_list_bufs()
  for _, v in pairs(buffers) do
    if is_qf_buffer(v) then
      return v, true
    end
  end
  return nil, false
end

---@class Util
local M = {}

M.toggle_sign_column = function()
  local newState = if_then_else(vim.o.signcolumn == 'yes', 'no', 'yes')
  vim.o.signcolumn = newState
end

M.clear_qf_list = function()
  vim.api.nvim_command('cexpr []')
end

M.exec_qf_list = function()
  local user_input = vim.fn.input('Execute:\n', '', 'file')
  local cmd = 'cdo ' .. user_input
  vim.api.nvim_command(cmd)
end

M.toggle_qf_list = function()
  local buf_nr, is_open = qf_is_open()
  local action = if_then_else(is_open, 'close', 'open')
  toggle_qf_list(buf_nr, action)
end

-- call f(...) without omitting errors
M.call_silent = function(f, ...)
  pcall(f, ...)
end

return M
