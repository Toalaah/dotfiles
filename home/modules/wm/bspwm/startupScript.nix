{
  cfg,
  config,
  lib,
  pkgs,
}: ''
  pkill bspc
  ${lib.optionalString (cfg.statusBar == "eww") "pkill eww"}
  ${lib.optionalString (cfg.statusBar == "tint2") "pkill tint2"}
  pkill sxhkd
  pkill volumeicon

  xset r rate 200 30 &
  xrdb -merge ${config.xdg.cacheHome}/wal/colors.Xresources &
  xrdb -merge ${config.xresources.path} &

  ${pkgs.hsetroot}/bin/hsetroot -solid "#3D405B"

  if test -d ${config.home.homeDirectory}/.local/startup.d; then
    for f in ${config.home.homeDirectory}/.local/startup.d/*; do
      echo $f
      test -x $f && . $f
    done
  fi

  ${lib.optionalString (cfg.statusBar == "tint2") "${pkgs.tint2}/bin/tint2 &"}
  ${pkgs.networkmanagerapplet}/bin/nm-applet &
  {
    for i in ''$(seq 5); do
      if [ ''$(${pkgs.volumeicon}/bin/volumeicon) ]; then
        break
      else
        sleep 1.5
      fi
    done
  } &

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
