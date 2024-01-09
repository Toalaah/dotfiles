{
  config,
  lib,
  pkgs,
  ...
}:
lib.vim.mkSimplePlugin {
  inherit config;
  plugin = pkgs.fetchFromGitHub {
    owner = "kaarmu";
    repo = "typst.vim";
    rev = "630bb8b7faf1fe02c253673a37a70c135ad43a40";
    sha256 = "sha256-lm6V0USAzFEIpziGC1kx7X4rqYOXCfztte9w62MlZp8=";
  };
  category = "languages";
  noSetup = true;
  extraPluginConfig = _: {
    ft = "typst";
  };
}
