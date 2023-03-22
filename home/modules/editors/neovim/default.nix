{
  config,
  lib,
  neovim-nightly,
  pkgs,
  ...
}:
with lib; let
  cfg = config.editors.neovim;
in {
  options = {
    editors.neovim = {
      enable = mkEnableOption "neovim";
      useNightly = mkEnableOption "use nightly neovim";
      configureAliases = mkOption {
        type = types.bool;
        default = true;
        description = "alias 'vi' and 'vim' to neovim binary";
      };
      setManpager = mkEnableOption "configure neovim as a manpager";
    };
  };
  config = mkMerge [
    (mkIf cfg.enable
      rec {
        home.packages = with pkgs; [
          fd
          sumneko-lua-language-server
        ];
        programs.neovim = {
          viAlias = cfg.configureAliases;
          vimAlias = cfg.configureAliases;
          enable = true;
          package = (
            if cfg.useNightly
            then neovim-nightly.defaultPackage.${pkgs.system}
            else pkgs.neovim-unwrapped
          );
        };
        xdg.configFile."nvim" = {
          target = "nvim";
          source = ./config;
          recursive = true;
        };
        attributes.primaryUser.editor = "${programs.neovim.package}/bin/nvim";
        home.sessionVariables.EDITOR = "${programs.neovim.package}/bin/nvim";
      })

    (mkIf cfg.setManpager {
      assertions = [
        {
          assertion = cfg.enable;
          message = "Cannot set neovim as manpager if neovim is not enabled";
        }
      ];
      home.sessionVariables.MANPAGER = mkDefault "nvim +Man!";
    })
  ];
}
