{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.productivity.zathura;
in {
  options = {
    productivity.zathura.enable = mkEnableOption "zathura";
  };
  config = mkMerge [
    (mkIf cfg.enable {
      programs.zathura = {
        enable = true;
        options = {
          statusbar-h-padding = 0;
          statusbar-v-padding = 0;
          page-padding = 10;
        };
        mappings = {
          f = "toggle_fullscreen";
          "[fullscreen] f" = "toggle_fullscreen";
          R = "rotate";
          i = "recolor";
        };
        extraConfig = ''
        '';
      };
    })
  ];
}
