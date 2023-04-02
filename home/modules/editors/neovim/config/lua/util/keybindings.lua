-- adapted from https://github.com/ThePrimeagen/.dotfiles/blob/master/nvim/.config/nvim/lua/theprimeagen/keymap.lua
---@param mode 'n' | 'i' | 'v'
---@param bind_opts table | nil
---@return fun(lhs:string, rhs:string|function, desc:string, user_opts?:table)
local bind = function(mode, bind_opts)
  bind_opts = bind_opts or { noremap = true }
  return function(lhs, rhs, desc, user_opts)
    local opts = vim.tbl_deep_extend('force', bind_opts, user_opts or {})
    if desc then opts.desc = desc end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

---@class KeymapUtils
local M = {}

M.nremap = bind('n', { noremap = false })
M.nnoremap = bind 'n'
M.inoremap = bind 'i'
M.vnoremap = bind 'v'

return M
