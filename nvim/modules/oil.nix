{
  config,
  lib,
  pkgs,
  ...
}:
lib.vim.mkSimplePlugin {
  inherit config;
  plugin = pkgs.fetchFromGitHub {
    owner = "stevearc";
    repo = "oil.nvim";
    rev = "3275996ce65f142d0e96b9fc2658f94e5bd43ad5";
    sha256 = "08j4f2i4wqkz37nnbf8jmp8lvvz3v3fzgg3ap3pm5paa724bjf0b";
  };
  category = ["tools"];
  extraPluginConfig = _: {
    cmd = "Oil";
  };
}
