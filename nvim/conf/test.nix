{
  pkgs,
  lib,
  ...
}: let
  nnmap = lib.vim.nnoremap;
in {
  imports = [./common];

  tools.oil = {
    enable = true;
    keys = [(nnmap "<leader><leader>" "<cmd>Oil<cr>" {desc = "Open file explorer";})];
    opts = {
      # keymaps."q" = "actions.close";
      # viewoptions.show_hidden = true;
    };
  };
}
