require("bufferline").setup{
  options = {
    max_name_length = 10,
    enforce_regular_tabs = true,
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end
  }
}
