{
  config,
  lib,
  pkgs,
  ...
}:
lib.vim.mkSimplePlugin {
  inherit config;
  plugin = pkgs.fetchFromGitHub {
    owner = "folke";
    repo = "which-key.nvim";
    rev = "4433e5ec9a507e5097571ed55c02ea9658fb268a";
    sha256 = "1inm7szfhji6l9k4khq9fvddbwj348gilgbd6b8nlygd7wz23y5s";
  };
  category = ["tools"];
  extraPluginConfig = _: {
    cmd = "WhichKey";
    event = ["BufReadPost" "BufNewFile"];
  };
}
