{lib, ...}: {
  completion = [
    {
      lhs = "<C-L>";
      rhs = lib.lua.rawLua ''
        function()
          return require('luasnip').expand()
        end
      '';
      mode = "i";
      silent = true;
    }
    {
      lhs = "<C-E>";
      rhs = lib.lua.rawLua ''
        function()
          local ls = require('luasnip')
          if ls.choice_active() then
            ls.change_choice(1)
          end
        end
      '';
      mode = ["i" "s"];
      silent = true;
    }
    {
      lhs = "<C-J>";
      rhs = lib.lua.rawLua "function() return require('luasnip').jump(1) end";
      mode = ["i" "s"];
      silent = true;
    }
    {
      lhs = "<C-K>";
      rhs = lib.lua.rawLua "function() return require('luasnip').jump(-1) end";
      mode = ["i" "s"];
      silent = true;
    }
  ];
}
