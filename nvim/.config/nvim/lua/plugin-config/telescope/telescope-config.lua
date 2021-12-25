-- TODO: add extension for file-search (will become deprecated)
require('telescope').setup({
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
  },
  pickers = {
    find_files = {
      theme = 'ivy',
      prompt_prefix = '🔍: ',
    },
  },
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--hidden=true',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    },
    prompt_prefix = '> ',
    selection_caret = '> ',
    entry_prefix = '  ',
    initial_mode = 'insert',
    selection_strategy = 'reset',
    sorting_strategy = 'descending',
    layout_strategy = 'vertical',
    layout_config = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter = require('telescope.sorters').get_fuzzy_file,
    file_ignore_patterns = { '.git/', 'node_modules', '.DS_Store' },
    generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    path_display = {},
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
  },
})

-- load extensions
require('telescope').load_extension('fzf')
require('telescope').load_extension('zoxide')
