return {
  sumneko_lua = {
    settings = {
      single_file_support = true,
      Lua = {
        semantic = { enable = false },
        diagnostics = {
          globals = { 'vim' },
          unusedLocalExclude = { '_*' },
        },
      },
    },
  },
}
