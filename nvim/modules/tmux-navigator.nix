{
  config,
  lib,
  pkgs,
  ...
}:
lib.vim.mkSimplePlugin {
  inherit config;
  plugin = pkgs.fetchFromGitHub {
    owner = "alexghergh";
    repo = "nvim-tmux-navigation";
    rev = "543f090a45cef28156162883d2412fffecb6b750";
    sha256 = "15wvf210izjkkvb3m3582px0j0ssznds2rd74vffzl6p96al0686";
  };
  category = "tools";
  extraPluginConfig = _: {
    cond =
      lib.lua.rawLua
      /*
      lua
      */
      ''
        function()
          return os.getenv("TMUX")
        end
      '';
  };
}
