{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.misc.services.picom;
in {
  options.misc.services.picom = {
    enable = mkEnableOption "picom";
    backend = mkOption {
      description = "Backend to use";
      default = "xrender";
      type = types.str;
    };
    extraArgs = mkOption {
      description = "extra arguments to pass to picom binary";
      default = [];
      type = types.listOf types.str;
    };
  };
  config = mkMerge [
    (mkIf cfg.enable {
      services.picom = {
        enable = true;
        extraArgs = cfg.extraArgs;
        shadow = false;
        shadowOpacity = 0.6;
        shadowExclude = [
          "name = 'polybar'"
          "name = 'rofi - Power'"
          "class_g = 'bspwm'"
          "class_g = 'dwm'"
          "class_g = 'eww-bar'"
        ];
        settings = {
          shadow-radius = 10;
          shadow-red = 0.0;
          shadow-green = 0.0;
          shadow-blue = 0.0;
          shadow-ignore-shaped = false;
          frame-opacity = 0.3;
          inactive-opacity-override = false;
          wm-ignore = false;
        };
        fade = true;
        fadeDelta = 4;
        fadeSteps = [
          0.05 # fade-in
          0.05 # fade-out
        ];
        activeOpacity = 1;
        inactiveOpacity = 1;
        wintypes = {
          popup_menu = {opacity = 1.0;};
          dropdown_menu = {opacity = 1.0;};
          dnd = {shadow = false;};
          dock = {shadow = true;};
          tooltip = {
            fade = true;
            shadow = true;
            opacity = 1.0;
            focus = true;
          };
        };
      };
    })
  ];
}
