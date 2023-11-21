{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.vim) mkSimplePlugin;
  inherit (lib.lua) rawLua;
in {
  imports = [
    (mkSimplePlugin {
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
        config = rawLua ''
          function()
            vim.g.mkdp_auto_close=0
          end
        '';
      };
    })
    (mkSimplePlugin {
      inherit config;
      plugin =
        pkgs.vimPlugins.clipboard-image-nvim
        // {
          owner = "ekickx";
          repo = "clipboard-image.nvim";
        };
      category = "tools";
      noSetup = true;
      extraPluginConfig = cfg: {
        ft = "markdown";
      };
    })
  ];
}
