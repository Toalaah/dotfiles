{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  user = config.attributes.primaryUser;
  terminal = user.terminal;
  browser = user.browser;
  cfg = config.wm.sxhkd;
in {
  options = {
    wm.sxhkd.enable = mkEnableOption "sxhkd";
  };
  config = mkMerge [
    (mkIf cfg.enable {
      services.sxhkd = {
        enable = true;
        # base keybindings, non-specific to any window manager
        keybindings = {
          "super + Escape" = "pkill -USR1 -x sxhkd; ${pkgs.libnotify}/bin/notify-send 'Keybindings reloaded'";
          "super + Return" = "${terminal}";
          "super + w" = "${browser}";
          "super + F1" = "${./scripts}/set-wallpaper";
          "super + shift + Escape" = "${./scripts}/lock-screen";
          "super + {0,minus,equal}" = "${./scripts}/set-volume {-m,-d,-i}";
          "{XF86AudioMute,XF86AudioLowerVolume,XF86AudioRaiseVolume}" = "${./scripts}/set-volume {-m,-d,-i}";
          "{XF86MonBrightnessUp,XF86MonBrightnessDown}" = "${./scripts}/set-brightness {-i,-d}";
          "XF86AudioMicMute" = "${./scripts}/toggle-microphone";
          "XF86WLAN" = "${./scripts}/toggle-wifi";
        };
      };
    })
  ];
}
