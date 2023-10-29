{
  config,
  lib,
  pkgs,
  ...
}:
lib.vim.mkSimplePlugin {
  inherit config;
  plugin = pkgs.fetchFromGitHub {
    owner = "romainl";
    repo = "vim-cool";
    rev = "662e7b11064cbeedad17c45d2fe926e78d3cd0b6";
    sha256 = "1ilddllx5riyzw4dx05rnvcxgngg7y2iydnkjn01wlddmid65p9k";
  };
  category = ["tools"];
  noSetup = true;
  extraPluginConfig = _: {
    event = ["BufReadPost" "BufNewFile"];
  };
}
