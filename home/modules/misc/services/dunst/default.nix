{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.misc.services.dunst;
in {
  options = {
    misc.services.dunst.enable = mkEnableOption "dunst";
  };
  config = mkMerge [
    (mkIf cfg.enable {
      systemd.user.services.dunst.Service.Environment = lib.mkForce [
        "DISPLAY=:0"
      ];
      services.dunst = {
        enable = true;
        settings = rec {
          global = {
            # TODO: ensure selected font is installed
            font = "JetBrains Mono";
            format = "<b>%s</b>\n%b";
            sort = "yes";
            indicate_hidden = "yes";
            alignment = "center";
            show_age_threshold = 60;
            word_wrap = "yes";
            ignore_newline = "no";
            transparency = 25;
            idle_threshold = 120;
            follow = "mouse";
            show_indicators = "yes";
            padding = 8;
            horizontal_padding = 12;
            separator_color = "auto";
          };
          urgency_low = {
            background = "#2D2D2D";
            foreground = "#D3D0C8";
            timeout = 5;
          };
          urgency_normal = urgency_low;
          urgency_critical = urgency_low;
        };
      };
    })
  ];
}
