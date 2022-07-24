local prettier_default_config = {
  cmd = {
    function(file)
      return string.format('prettier -w %s', file)
    end,
  },
}

local custom_fmt_config = function(cmd)
  return {
    cmd = {
      function(file)
        return string.format(cmd, file)
      end,
    },
  }
end

require('format').setup({
  javascript = { prettier_default_config },
  html = { prettier_default_config },
  vue = { prettier_default_config },
  typescript = { prettier_default_config },
  json = { prettier_default_config },
  markdown = { prettier_default_config },
  c = { custom_fmt_config('clang-format -i %s') },
  dart = { custom_fmt_config('dart-format -w %s') },
  lua = { custom_fmt_config('stylua -s %s') },
  python = { custom_fmt_config('black %s') },
  go = {
    {
      cmd = { 'gofmt -w', 'goimports -w' },
      tempfile_postfix = '.tmp',
    },
  },
  ['*'] = { prettier_default_config },
})
