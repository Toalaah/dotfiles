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
    home.shellAliases.vi = binPath;
    home.shellAliases.vim = binPath;
    attributes.primaryUser.editor = binPath;
    home.sessionVariables.EDITOR = binPath;
    home.sessionVariables.MANPAGER = mkDefault "nvim +Man!";
  };
}
