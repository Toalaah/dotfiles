---@return boolean
---@param v number
local function is_qf_buffer(v)
  return vim.api.nvim_buf_is_loaded(v) and (vim.api.nvim_buf_get_option(v, 'buftype') == 'quickfix')
end

---@param buf_nr number buffer-id of the quickfix list
---@param state 'open'|'close' action to take on qf list
local function toggle_qf_list(buf_nr, state)
  -- unload buffer if it is open
  if state == 'close' then vim.cmd('bunload ' .. buf_nr) end
  vim.cmd('c' .. state)
end

---@return number, boolean
local function is_qf_list_open()
  local buffers = vim.api.nvim_list_bufs()
  for _, v in pairs(buffers) do
    if is_qf_buffer(v) then return v, true end
  end
  return -1, false
end

---@class QFUtil
local M = {}

M.clear_qf_list = function() vim.cmd 'cexpr []' end

M.exec_qf_list = function()
  local user_input = vim.fn.input('Execute:\n', '', 'file')
  vim.cmd('cdo ' .. user_input)
end

M.toggle_qf_list = function()
  local buf_nr, is_open = is_qf_list_open()
  local action = 'close'
  if is_open then action = 'open' end
  toggle_qf_list(buf_nr, action)
end

return M
