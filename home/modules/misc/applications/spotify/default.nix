{
  config,
  lib,
  pkgs,
  spicetify-nix,
  ...
}:
with lib; let
  cfg = config.misc.applications.spotify;
  spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
in {
  imports = [
    spicetify-nix.homeManagerModule
  ];
  options = with types; {
    misc.applications.spotify = {
      enable = mkEnableOption "spotify";

      theme = mkOption {
        type = str;
        default = "default";
        example = "catppuccin-mocha";
        description = ''
          Skin to use for spotify
          See https://github.com/the-argus/spicetify-nix/blob/master/pkgs/themes.nix
        '';
      };

      colorScheme = mkOption {
        type = str;
        default = "default";
        example = "flamingo";
        description = ''
          Colorscheme to use based on selected theme
        '';
      };

      extensions = mkOption {
        default = with spicetify-nix.packages.${pkgs.system}.default.extensions; [lastfm genre];
        description = ''
          Spicetify extensions to enable
          See https://github.com/the-argus/spicetify-nix/blob/master/EXTENSIONS.md
        '';
      };

      windowManagerSupport = mkEnableOption "Apply windowManagerPatch to spicetify package. Offers improved support for tiling window managers";
    };
  };

  config = mkMerge [
    (mkIf cfg.enable {
      assertions = [];
      programs.spicetify = {
        enable = true;
        theme = spicePkgs.themes.${cfg.theme};
        windowManagerPatch = cfg.windowManagerSupport;
        colorScheme = cfg.colorScheme;
        enabledExtensions = cfg.extensions;
      };
    })
  ];
}
