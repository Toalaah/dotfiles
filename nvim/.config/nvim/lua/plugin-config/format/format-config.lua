require('format').setup({
  ['*'] = {
    { cmd = { "sed -i 's/[ \t]*$//'" } }, -- remove trailing whitespace
  },
  vim = {
    {
      cmd = { 'luafmt -w replace' },
      start_pattern = '^lua << EOF$',
      end_pattern = '^EOF$',
    },
  },
  vimwiki = {
    {
      cmd = { 'prettier -w --parser babel' },
      start_pattern = '^{{{javascript$',
      end_pattern = '^}}}$',
    },
  },
  dart = {
    {
      cmd = {
        function(file)
          return string.format('dartfmt -w %s', file)
        end,
      },
    },
  },
  lua = {
    {
      cmd = {
        function(file)
          return string.format('stylua %s', file)
        end,
      },
    },
  },
  go = {
    {
      cmd = { 'gofmt -w', 'goimports -w' },
      tempfile_postfix = '.tmp',
    },
  },
  javascript = {
    {
      cmd = {
        function(file)
          return string.format('prettier -w %s', file)
        end,
      },
    },
  },
  vue = {
    {
      cmd = {
        function(file)
          return string.format('prettier -w %s', file)
        end,
      },
    },
  },
  python = {
    {
      cmd = {
        function(file)
          return string.format('black %s', file)
        end,
      },
    },
  },
  typescript = {
    {
      cmd = {
        function(file)
          return string.format('prettier -w %s', file)
        end,
      },
    },
  },
  json = {
    {
      cmd = {
        function(file)
          return string.format('prettier -w %s', file)
        end,
      },
    },
  },
  markdown = {
    { cmd = { 'prettier -w' } },
    {
      cmd = { 'black' },
      start_pattern = '^```python$',
      end_pattern = '^```$',
      target = 'current',
    },
  },
})
