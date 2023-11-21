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
    rev = "e76ad83e4a3e303ccf50104a251118613162f8a8";
    sha256 = "11ki7cz0wl11k6b0lz9217vgyz3sbdgg50y8azb1n2405731sm10";
  };
  category = ["editor"];
  extraPluginConfig = _: {
    event = ["BufReadPost" "BufNewFile"];
  };
}
