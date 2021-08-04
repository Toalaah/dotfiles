require('bufferline').setup{
  options = {
    separator_style = "thin",
    enforce_regular_tabs = true,
    max_name_length = 18,
    tab_size = 18,
    always_show_bufferline = true,
    show_close_icon = false,
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end
  }
}
