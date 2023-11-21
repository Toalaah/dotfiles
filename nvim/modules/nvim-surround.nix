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
    rev = "0855a89e00a5822c3a482a82e5223fcf2e9ede13";
    sha256 = "09riinjjh96nrs357ay886j8gs6cgkhj3zwngm44pf8p04w2w81n";
  };
  category = ["tools"];
  extraPluginConfig = _: {
    event = ["BufReadPost" "BufNewFile"];
  };
}
