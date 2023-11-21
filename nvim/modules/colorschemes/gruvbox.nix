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
    rev = "517b012757fbe7a4d6e507baf5cc75837e62734f";
    sha256 = "1ndbd6mn19g3wiqshw9wckkl976kjvgy2dc3lmb92cyxjni8a507";
  };
  category = "colorschemes";
  extraPluginConfig = _cfg: {
    priority = 1000;
    lazy = false;
  };
}
