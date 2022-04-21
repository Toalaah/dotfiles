require('renamer').setup({
  title = 'Rename',
  padding = {
    top = 0,
    left = 0,
    bottom = 0,
    right = 0,
  },
  border = true,
  border_chars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
  show_refs = true,
  with_qf_list = false,
  with_popup = true,
  handler = nil,
})


local r = require"renamer"
r.setup {}
r._apply_workspace_edit = function(resp)
  local params = vim.lsp.util.make_position_params()
  local results_lsp, _ = vim.lsp.buf_request_sync(0,
      require"renamer.constants".strings.lsp_req_rename, params)
  local client_id = results_lsp and next(results_lsp) or nil
  local client = vim.lsp.get_client_by_id(client_id)
  require"vim.lsp.util".apply_workspace_edit(resp, client.offset_encoding)
end
