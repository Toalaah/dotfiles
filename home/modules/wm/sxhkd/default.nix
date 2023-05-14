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
        keybindings = let
          scriptsPath = ../../tools/binscripts/scripts;
        in {
          "super + Escape" = "pkill -USR1 -x sxhkd; ${pkgs.libnotify}/bin/notify-send 'Keybindings reloaded'";
          "super + Return" = "${terminal}";
          "super + w" = "${browser}";
          "super + F1" = "${scriptsPath}/set-wallpaper";
          "super + shift + Escape" = "${pkgs.elogind}/bin/loginctl lock-session";
          "super + {0,minus,equal}" = "${scriptsPath}/set-volume {-m,-d,-i}";
          "{XF86AudioMute,XF86AudioLowerVolume,XF86AudioRaiseVolume}" = "${scriptsPath}/set-volume {-m,-d,-i}";
          "{XF86MonBrightnessUp,XF86MonBrightnessDown}" = "${scriptsPath}/set-brightness {-i,-d}";
          "XF86AudioMicMute" = "${scriptsPath}/toggle-microphone";
          "XF86WLAN" = "${scriptsPath}/toggle-wifi";
        };
      };
    })
  ];
}
