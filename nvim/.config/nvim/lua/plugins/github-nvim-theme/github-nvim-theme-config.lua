-- if string.match(vim.g.colors_name, "github_*") then
require('github-theme').setup({
  function_style = 'none',
  comment_style = 'italic',
  variable_style = 'none',
  dark_float = true,
  dark_sidebar = true,
  hide_end_of_buffer = false,
  transparent = false,
  overrides = function()
    return {
      TSField = {},
    }
  end,
})
-- end
