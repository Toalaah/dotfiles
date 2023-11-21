{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    (lib.vim.mkSimplePlugin {
      inherit config;
      plugin = pkgs.fetchFromGitHub {
        owner = "echasnovski";
        repo = "mini.pairs";
        rev = "71f117fd57f930da6ef4126b24f594dd398bac26";
        sha256 = "160dmnlj3i1z3iydqvaxxiwiaqvh55kv5929rpfprg9ln40dj6yf";
      };
      category = "tools";
      moduleName = "mini-pairs";
      extraPluginConfig = cfg: {
        event = ["BufReadPost" "BufNewFile"];
      };
    })

    (lib.vim.mkSimplePlugin {
      inherit config;
      plugin = pkgs.fetchFromGitHub {
        owner = "echasnovski";
        repo = "mini.ai";
        rev = "4a2e387b121352dfb478f440c9a5313a9d97006c";
        sha256 = "0n511ryl5k9m4bzzcd2drrk7b7baf4xyzs2sfgiqvsnn8n0zpw1d";
      };
      category = "tools";
      moduleName = "mini-ai";
      extraPluginConfig = cfg: {
        event = ["BufReadPost" "BufNewFile"];
      };
    })
  ];
}
