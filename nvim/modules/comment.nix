{
  config,
  lib,
  pkgs,
  ...
}:
lib.vim.mkSimplePlugin {
  inherit config;
  plugin = pkgs.fetchFromGitHub {
    owner = "numtostr";
    repo = "comment.nvim";
    rev = "0236521ea582747b58869cb72f70ccfa967d2e89";
    sha256 = "1mvi7c6n9ybgs6lfylzhkidifa6jkgsbj808knx57blvi5k7blgr";
  };
  extraPluginConfig = _: {
    event = ["BufReadPost" "BufNewFile"];
  };
  category = "editor";
}
