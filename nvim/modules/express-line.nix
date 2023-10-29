{
  config,
  lib,
  pkgs,
  ...
}:
lib.vim.mkSimplePlugin {
  inherit config;
  plugin = pkgs.fetchFromGitHub {
    owner = "tjdevries";
    repo = "express_line.nvim";
    rev = "30f04edb9647d9ea7c08d0bdbfad33faf5bcda57";
    sha256 = "1mr1mlrvz1w8xs4w02m8c5679vyi3dh5r5bjfhi96q3y0f71qp6m";
  };
  moduleName = "express-line";
  extraPluginConfig = _: {
    event = ["BufReadPost" "BufNewFile"];
    config = lib.lua.rawLua ''
      function(_, opts)
        require('el').setup(opts)
      end
    '';
  };
  category = "ui";
}
