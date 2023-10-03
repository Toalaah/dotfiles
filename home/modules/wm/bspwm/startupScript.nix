{
  cfg,
  config,
  lib,
  pkgs,
}: ''
  pkill bspc
  ${lib.optionalString (cfg.statusBar == "eww") "pkill eww"}
  ${lib.optionalString (cfg.statusBar == "tint2") "pgrep tint2 | xargs kill"}
  pkill sxhkd

  xset r rate 200 30 &
  xrdb -merge ${config.xdg.cacheHome}/wal/colors.Xresources &
  xrdb -merge ${config.xresources.path} &

  ${pkgs.hsetroot}/bin/hsetroot -solid "#3D405B"

  ${lib.optionalString (cfg.statusBar == "tint2") "${pkgs.tint2}/bin/tint2 &"}
  ${pkgs.networkmanagerapplet}/bin/nm-applet &
  ${pkgs.volumeicon}/bin/volumeicon &

  ${
    lib.optionalString config.misc.services.dunst.enable
    "${config.services.dunst.package}/bin/dunst &"
  }
  ${pkgs.sxhkd}/bin/sxhkd &
  ${pkgs.parcellite}/bin/parcellite -n &
  ${pkgs.unclutter}/bin/unclutter -idle 2 &

  ${lib.optionalString (cfg.statusBar == "eww") ''
    {
      ${pkgs.eww}/bin/eww daemon
      ${pkgs.eww}/bin/eww open bar
      ${pkgs.xdo}/bin/xdo above -t ''$(${pkgs.xdo}/bin/xdo id -n root) -n eww
    } &
  ''}
''
