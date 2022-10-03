local opts = {
  rename_in_select = true,
  code_action_lightbulb = {
    enable = false,
    virtual_text = false,
  },
  symbol_in_winbar = {
    enable = false,
  },
}

require('lspsaga').init_lsp_saga(opts)
