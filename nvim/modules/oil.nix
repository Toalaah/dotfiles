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
    rev = "af04969c437e0c46a2b3c86d7892458e878ecc40";
    sha256 = "17mi1hs3jmmrxqxhykqf0xj91ssxzzzig7gmdlyak6pgwln2ziyr";
  };
  category = ["tools"];
  extraPluginConfig = _: {
    cmd = "Oil";
  };
}
