{
  config,
  lib,
  pkgs,
  ...
}:
lib.vim.mkSimplePlugin rec {
  inherit config;
  plugin = pkgs.fetchFromGitHub {
    owner = "theprimeagen";
    repo = "harpoon";
    rev = "c1aebbad9e3d13f20bedb8f2ce8b3a94e39e424a";
    sha256 = "0wqxg31z7gi7ap8r0057lpadywx3d245ghlljr6mkmp0jz3waad5";
  };
  category = "tools";
  extraConfig = lib.mkIf (config.telescope.enable or false) {
    telescope.extensions.harpoon = {src = plugin;};
  };
}
