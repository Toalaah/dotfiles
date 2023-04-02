---@class autocmd_opts
---@field desc? string Autocmd description.
---@field event string|string[] Event(s) to run autocommand on.
---@field pattern string|string[] Patterns to activate autocmd in.
---@field group? string Optional override of group name
---@field callback string|function Vim command or lua function to run on autocommand trigger.
---@param opts autocmd_opts
--- Wraps `vim.api.nvim_create_autocmd`
local function create_autocmd(opts)
  if not opts.callback or not opts.pattern or not opts.event then
    vim.defer_fn(function() vim.notify('Could not create autocmd: ' .. vim.inspect(opts), vim.log.levels.WARN) end, 100)
    return
  end
  -- compute unique group name based on opts.desc. Strip any special characters and whitespaces, replacing all with an underscore.
  local group_name = opts.group
  if not group_name then
    group_name = 'user_autocmd_' .. (opts.desc and opts.desc:gsub('[^%w_]', '_'):gsub('%s+', '_')):lower()
  end
  vim.api.nvim_create_autocmd(opts.event, {
    pattern = opts.pattern,
    callback = opts.callback,
    group = vim.api.nvim_create_augroup(group_name, { clear = true }),
    desc = opts.desc,
  })
end

create_autocmd {
  event = 'TextYankPost',
  pattern = '*',
  callback = function() vim.highlight.on_yank { higroup = 'IncSearch', timeout = 500 } end,
  desc = 'Highlight copied content after yank',
}

create_autocmd {
  event = 'FileType',
  pattern = '*',
  callback = function() vim.cmd.checktime() end,
  desc = 'Reload file if it changed after regaining focus',
}
