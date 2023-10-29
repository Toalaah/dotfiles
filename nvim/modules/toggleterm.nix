{
  config,
  lib,
  pkgs,
  ...
}:
lib.vim.mkSimplePlugin {
  inherit config;
  plugin = pkgs.fetchFromGitHub {
    owner = "akinsho";
    repo = "toggleterm.nvim";
    rev = "c80844fd52ba76f48fabf83e2b9f9b93273f418d";
    sha256 = "19rbq39m7c1v9yrfmlwmfmxgv5d9bwcjbgjdp3cin409fnl4rv6b";
  };
  category = ["tools"];
  extraPluginConfig = _: {
    cmd = "ToggleTerm";
  };
}
