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
        rev = "6f6bd7ed5757b40bc29c73dac0d743e4e6978124";
        sha256 = "1p596glyi44pp80n6sn24whrdrgj6zxicr5hb6py2v9ic8dfs7bm";
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
        rev = "10ad2ed049fb681a829b44aeb23443c0a9c910ae";
        sha256 = "0lpjpgh4ymgcfq8z9hij08f7xiql5mlgrzpd5fp8p73pjiah5lgq";
      };
      category = "tools";
      moduleName = "mini-ai";
      extraPluginConfig = cfg: {
        event = ["BufReadPost" "BufNewFile"];
      };
    })
  ];
}
