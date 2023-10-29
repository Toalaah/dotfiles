{
  config,
  lib,
  pkgs,
  ...
}:
lib.vim.mkSimplePlugin {
  inherit config;
  plugin = pkgs.fetchFromGitHub {
    owner = "max397574";
    repo = "better-escape.nvim";
    rev = "7031dc734add47bb71c010e0551829fa5799375f";
    sha256 = "0pabbcx5b5varpd9xc9lrl767fv1591h0r4zk28zb31finx5i48k";
  };
  category = ["editor"];
  extraPluginConfig = _: {
    main = "better_escape";
    event = "InsertEnter";
  };
}
