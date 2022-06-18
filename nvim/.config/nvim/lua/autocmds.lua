local _env = vim.api.nvim_create_augroup("__env", {clear=true})
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = ".env*",
  group = _env,
  callback = function(args)
    vim.diagnostic.disable(args.buf)
    vim.bo.filetype="sh"
  end
})
