local M = {
  'williamboman/mason.nvim',
  dependencies = {
    { 'williamboman/mason-lspconfig.nvim' },
    { 'neovim/nvim-lspconfig' },
  },
}

function M.config()
  require('mason').setup {
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 5,
    ui = {
      check_outdated_packages_on_open = false,
    },
  }

  require('mason-lspconfig').setup {
    ensure_installed = { 'sumneko_lua', 'rust_analyzer' },
  }

  local function format_write()
    vim.lsp.buf.format { filter = function(c) return c.name ~= 'tsserver' end, async = false }
    vim.cmd.write()
  end

  ---@diagnostic disable-next-line: unused-local
  local function on_attach(client, bufnr)
    local bufopts = { silent = true, buffer = bufnr }
    local nnoremap = require('util.keybindings').nnoremap

    nnoremap('<leader>lD', vim.lsp.buf.declaration, 'Goto declaration', bufopts)
    nnoremap(
      '<leader>lw',
      function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
      'List workspaces',
      bufopts
    )
    nnoremap('K', vim.lsp.buf.hover, 'Hover', bufopts)
    nnoremap('<leader>lR', vim.lsp.buf.rename, 'Rename', bufopts)
    nnoremap('<leader>la', vim.lsp.buf.code_action, 'Code action', bufopts)
    nnoremap('<leader>p', function() format_write() end, 'Format file', bufopts)
    -- nnoremap('<leader>ld', vim.lsp.buf.definition, bufopts)
    -- nnoremap('<leader>li', vim.lsp.buf.implementation, bufopts)
    -- nnoremap('<leader>lr', vim.lsp.buf.references, bufopts)
    nnoremap('<leader>ld', '<Cmd>Trouble lsp_definitions<CR>', 'Goto definition', bufopts)
    nnoremap('<leader>li', '<Cmd>TroubleToggle lsp_implementations<CR>', 'View implementations', bufopts)
    nnoremap('<leader>lr', '<Cmd>TroubleToggle lsp_references<CR>', 'View references', bufopts)
  end

  require('mason-lspconfig').setup_handlers {
    -- default handler
    function(server_name) require('lspconfig')[server_name].setup { on_attach = on_attach } end,
    -- any specialized per-language overrides can be made here
    ['rust_analyzer'] = function() require('rust-tools').setup { on_attach = on_attach } end,
    ['sumneko_lua'] = function()
      require('lspconfig').sumneko_lua.setup {
        on_attach = on_attach,
        settings = {
          single_file_support = true,
          Lua = {
            semantic = { enable = false },
            diagnostics = {
              globals = { 'vim' },
            },
          },
        },
      }
    end,
  }
end

return M
