{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.terminals.alacritty;
  alacrittyThemes = map (x: strings.removeSuffix ".nix" x) (builtins.attrNames (builtins.readDir ./themes));
in {
  options = {
    terminals.alacritty = {
      enable = mkEnableOption "alacritty";
      theme = mkOption {
        type = with types; nullOr (enum alacrittyThemes);
        default = null;
        description = "theme to use";
      };
      fontSize = mkOption {
        type = types.int;
        default = 15;
        description = "font size to use";
      };
      # TODO: ensure selected font is installed
      fontFamily = mkOption {
        type = types.str;
        default = "JetBrains Mono";
        description = "font family to use";
      };
    };
  };

  config = mkMerge [
    (mkIf cfg.enable {
      assertions = [];
      attributes.primaryUser.terminal = "${config.programs.alacritty.package}/bin/alacritty";
      programs.alacritty = {
        enable = true;
        settings = let
          colorScheme =
            if (cfg.theme != null)
            then (import ./themes/${cfg.theme}.nix)
            else {};
        in {
          cursor = {
            blink_interval = 500;
            style = {
              blinking = "On";
              shape = "Block";
            };
          };
          draw_bold_text_with_bright_colors = true;
          font = {
            size = cfg.fontSize;
            bold = {
              family = cfg.fontFamily;
              style = "Bold";
            };
            bold_italic = {
              family = cfg.fontFamily;
              style = "Bold Italic";
            };
            italic = {
              family = cfg.fontFamily;
              style = "Italic";
            };
            light = {
              family = cfg.fontFamily;
              style = "Light";
            };
            normal = {
              family = cfg.fontFamily;
              style = "Regular";
            };
          };
          key_bindings = [
            (
              if pkgs.stdenv.isDarwin
              then {
                action = "ToggleFullscreen";
                key = "F";
                mods = "Command|Shift";
              }
              else null
            )
          ];
          scrolling.history = 10000;
          colors = colorScheme;
          window = {
            decorations = "none";
            dimensions = {
              columns = 82;
              lines = 52;
            };
            opacity = 0.95;
            padding = {
              x = 0;
              y = 0;
            };
            position = {
              x = 0;
              y = 0;
            };
          };
        };
      };
    })
  ];
}
