{
  config,
  lib,
  pkgs,
  ...
}:
lib.vim.mkSimplePlugin {
  inherit config;
  plugin = pkgs.fetchFromGitHub {
    owner = "ellisonleao";
    repo = "gruvbox.nvim";
    rev = "477c62493c82684ed510c4f70eaf83802e398898";
    sha256 = "0250c24c6n6yri48l288irdawhqs16qna3y74rdkgjd2jvh66vdm";
  };
  category = "colorschemes";
  extraPluginConfig = _cfg: {
    priority = 1000;
    lazy = false;
  };
}
