{
  config,
  lib,
  pkgs,
  ...
}:
lib.vim.mkSimplePlugin {
  inherit config;
  plugin =
    pkgs.vimPlugins.markdown-preview-nvim
    // {
      owner = "iamcco";
      repo = "markdown-preview.nvim";
    };
  category = "tools";
  noSetup = true;
  extraPluginConfig = cfg: {
    ft = "markdown";
  };
}
