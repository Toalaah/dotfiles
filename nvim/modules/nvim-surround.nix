{
  config,
  lib,
  pkgs,
  ...
}:
lib.vim.mkSimplePlugin {
  inherit config;
  plugin = pkgs.fetchFromGitHub {
    owner = "kylechui";
    repo = "nvim-surround";
    rev = "1c2ef599abeeb98e40706830bcd27e90e259367a";
    sha256 = "06j190qns6fscxp7mnr6zl5bipzbc4w478z5x5g2awghc0iwzkcr";
  };
  category = ["tools"];
  extraPluginConfig = _: {
    event = ["BufReadPost" "BufNewFile"];
  };
}
