{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  binPath = "${pkgs.nvim}/bin/nvim";
in {
  options.editors.neovim.enable = mkEnableOption "neovim";
  config = mkIf config.editors.neovim.enable {
    home.packages = [pkgs.nvim];
    home.shellAliases.vi = "nvim";
    home.shellAliases.vim = "nvim";
    attributes.primaryUser.editor = "nvim";
    home.sessionVariables.EDITOR = "nvim";
    home.sessionVariables.MANPAGER = mkDefault "nvim +Man!";
  };
}
