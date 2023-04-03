{
  cfg,
  config,
  lib,
  pkgs,
}: ''
  pkill bspc
  ${lib.optionalString (cfg.statusBar == "eww") "pkill eww"}
  pkill sxhkd
  pkill bspswallow
  ${
    lib.optionalString config.misc.services.picom.enable
    ''
      systemctl --user import-environment XAUTHORITY DISPLAY
      systemctl --user restart picom.service
    ''
  }

  xset r rate 200 30
  xrdb -merge ${config.xdg.cacheHome}/wal/colors.Xresources
  xrdb -merge ${config.xresources.path}

  [ -f ${config.home.homeDirectory}/.fehbg ] && nix-shell -p feh --command ${config.home.homeDirectory}/.fehbg

  ${
    lib.optionalString config.misc.services.dunst.enable
    "${config.services.dunst.package}/bin/dunst &"
  }
  ${pkgs.sxhkd}/bin/sxhkd &
  ${pkgs.parcellite}/bin/parcellite -n &
  ${pkgs.unclutter}/bin/unclutter -idle 2 &

  ${lib.optionalString (cfg.statusBar == "eww") ''
    ${pkgs.eww}/bin/eww daemon
    ${pkgs.eww}/bin/eww open bar
  ''}
  ${./scripts/bspwm_bspswallow} &
''
