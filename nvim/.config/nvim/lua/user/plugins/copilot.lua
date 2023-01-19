return {
  'zbirenbaum/copilot.lua',
  event = 'InsertEnter',
  enabled = false,
  config = function() require('copilot').setup() end,
}
