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
        rev = "5a9a6ac29a7805c4783cda21b80a1e361964b3f2";
        sha256 = "sha256-9DIfUVcU5aZXPUGueBnUlv2IgUh69bDx4vGnGeNJ+u0=";
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
        rev = "cbe9dfa162c178946afa689dd3f42d4ea8bf89c1";
        sha256 = "sha256-poNiZqRMuw2+xlPsY8BIA3OCjRCpbh7uAyaWmlgPCUs=";
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
        sha256 = "sha256-aXCkJxsQoa8JjYqL/l/lZ7Rep9xPs0lOwxkLb6won+k=";
      };
      category = "git";
      noSetup = true;
      extraPluginConfig = cfg: {
        event = ["BufReadPre" "BufNewFile"];
      };
    })
  ];
}
