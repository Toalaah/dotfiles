local opts = {
  rename_in_select = true,
  code_action_lightbulb = {
    enable = true,
    virtual_text = false,
  },
}

require('lspsaga').init_lsp_saga(opts)
