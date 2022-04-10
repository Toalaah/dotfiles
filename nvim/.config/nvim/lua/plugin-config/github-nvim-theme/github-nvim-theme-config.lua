require('github-theme').setup({
  theme_style = 'dark_default',
  function_style = 'none',
  comment_style = 'italic',
  variable_style = 'none',
  dark_float = true,
  dark_sidebar = true,
  transparent = false,
  overrides = function()
    return {
      TSField = {},
    }
  end,
})
