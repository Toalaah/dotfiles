local get_capabilities = function()
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  return capabilities
end

local lsp_installer = require('nvim-lsp-installer')
-- define all the servers we want to be auto-installed
local servers = {
  'bashls',
  'clangd',
  'eslint',
  'gopls',
  'html',
  'pyright',
  'sumneko_lua',
  'texlab',
  'tsserver',
  'volar',
  'yamlls',
}

-- install missing servers
for _, name in pairs(servers) do
  local ok, server = lsp_installer.get_server(name)
  if ok then
    if not server:is_installed() then
      print('Installing ' .. name)
      server:install()
    end
  end
end

-- setup servers
lsp_installer.on_server_ready(function(server)
  local opts = { capabilities = get_capabilities() }

  if server.name == 'yamlls' then
    opts.settings = {
      yaml = {
        schemas = {
          ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
          ['https://raw.githubusercontent.com/ansible-community/schemas/main/f/ansible-playbook.json'] = 'playbook.yml',
          ['https://raw.githubusercontent.com/ansible-community/schemas/main/f/ansible-tasks.json'] = '/tasks/*.yml',
          ['https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json'] = '/*.gitlab-ci.yml',
          kubernetes = '/*.k8s.y*ml',
        },
      },
    }
  end

  if server.name == 'sumneko_lua' then
    opts.settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' },
        },
      },
    }
  end

  server:setup(opts)
end)
