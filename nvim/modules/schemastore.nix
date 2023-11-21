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
    rev = "357fe900baae09e1a3fcef913e49733d05d1f888";
    sha256 = "1dk08b9sb825z18zcq3av3wr8c2xk5szakgiis5c25938jw0c1hl";
  };
  category = ["tools"];
  noSetup = true;
}
