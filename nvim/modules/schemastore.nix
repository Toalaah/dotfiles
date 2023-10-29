{
  config,
  lib,
  pkgs,
  ...
}:
lib.vim.mkSimplePlugin {
  inherit config;
  plugin = pkgs.fetchFromGitHub {
    owner = "b0o";
    repo = "schemastore.nvim";
    rev = "847f69b4bd50ad09c7d66943bc690682a3e35573";
    sha256 = "0jg3hdw26s8bmfirdi2nbchkmkakmggl0h5x2jx7hn5d9yn3ps4h";
  };
  category = ["tools"];
  noSetup = true;
}
