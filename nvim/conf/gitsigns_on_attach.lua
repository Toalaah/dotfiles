function(bufnr)
  local gs = package.loaded.gitsigns

  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end

  -- Navigation
  map('n', ']c', function()
    if vim.wo.diff then return ']c' end
    vim.schedule(function() gs.next_hunk() end)
    return '<Ignore>'
  end, {expr=true})

  map('n', '[c', function()
    if vim.wo.diff then return '[c' end
    vim.schedule(function() gs.prev_hunk() end)
    return '<Ignore>'
  end, {expr=true})

  -- Actions
  map('n', '<leader>ghs', gs.stage_hunk)
  map('n', '<leader>ghr', gs.reset_hunk)
  map('n', '<leader>ghS', gs.stage_buffer)
  map('n', '<leader>ghR', gs.reset_buffer)
  map('n', '<leader>ghv', gs.preview_hunk)
  map('n', '<leader>gb', function() gs.blame_line{full=true} end)
  map('n', '<leader>ghd', gs.diffthis)
  map('n', '<leader>ghD', function() gs.diffthis('~') end)

  -- Text object
  map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
end
