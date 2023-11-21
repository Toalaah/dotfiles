{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.vim) mkSimplePlugin;
in {
  imports = [
    (mkSimplePlugin {
      inherit config;
      plugin = pkgs.fetchFromGitHub {
        owner = "lewis6991";
        repo = "gitsigns.nvim";
        rev = "af0f583cd35286dd6f0e3ed52622728703237e50";
        sha256 = "04qr0zm8cfrsf306jswah4cja8dsih3b41ikakcbvgq08qsngj86";
      };
      category = "git";
      extraPluginConfig = cfg: {
        event = ["BufReadPre" "BufNewFile"];
      };
    })

    (mkSimplePlugin {
      inherit config;
      plugin = pkgs.fetchFromGitHub {
        owner = "tpope";
        repo = "vim-fugitive";
        rev = "46eaf8918b347906789df296143117774e827616";
        sha256 = "b6x8suCHRMYzqu/PGlt5FPg+7/CilkjWzlkBZ3i3H/c=";
      };
      category = "git";
      noSetup = true;
      moduleName = "fugitive";
      extraPluginConfig = cfg: {
        cmd = "Git";
      };
    })

    (mkSimplePlugin {
      inherit config;
      plugin = pkgs.fetchFromGitHub {
        owner = "rhysd";
        repo = "committia.vim";
        rev = "0b4df1a7f48ffbc23b009bd14d58ee1be541917c";
        sha256 = "1scz52n6y2qrqd74kcsgvjkmxd37wmgzx2wail4sz88h3cks8w39";
      };
      category = "git";
      noSetup = true;
      extraPluginConfig = cfg: {
        event = ["BufReadPre" "BufNewFile"];
      };
    })
  ];
}
