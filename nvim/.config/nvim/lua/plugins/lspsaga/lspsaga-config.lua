local opts = {
rename_in_select = true,
symbol_in_winbar = {
    in_custom = false,
    enable = false,
    separator = '  ',
    show_file = true,
    click_support = false,
},
}

require('lspsaga').init_lsp_saga(opts)
