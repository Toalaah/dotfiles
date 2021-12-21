require('Comment').setup({
  -- add a space b/w comment and the line
  padding = true,

  -- whether the cursor should stay at its position
  sticky = true,

  -- lines to be ignored while comment/uncomment.
  ignore = nil,

  -- i want to manually set keybindings using which-key + the comment nvim api,
  -- so to make sure nothing conflicts i set all the keymappings to nil
  toggler = nil,
  opleader = nil,
  extra = nil,
  mappings = nil,

  pre_hook = nil,
  post_hook = nil,
})
