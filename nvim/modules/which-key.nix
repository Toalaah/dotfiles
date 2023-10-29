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
    rev = "6962dae3565369363b59dd51fb206051555fcb4d";
    sha256 = "1fcwd2cv9qlfhpdxza2syrqzdhhy672jwqbr8kl3mafg15wpkxaa";
  };
  category = ["tools"];
  extraPluginConfig = _: {
    cmd = "WhichKey";
    event = ["BufReadPost" "BufNewFile"];
  };
}
