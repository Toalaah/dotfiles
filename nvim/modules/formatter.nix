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
    repo = "conform.nvim";
    rev = "1281e26948fc06994e0e0cdcaafdd9bbd28929e7";
    sha256 = "0drm8jfnfw5p2g3g69akgjyz5nkx72lnx6fc4b8s2ycvzn89zj3x";
  };
  category = ["editor"];
  extraPluginConfig = _: {
    event = ["BufReadPost" "BufNewFile"];
  };
}
