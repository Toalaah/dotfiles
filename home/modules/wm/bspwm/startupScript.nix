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
  ${lib.optionalString config.misc.services.picom.enable "pkill picom"}

  ${let
    timeOut = builtins.toString config.wm.general.screenLock.timeout;
  in
    lib.optionalString config.wm.general.screenLock.enable ''
      ${config.wm.general.screenLock.command}
      xset +dpms dpms ${timeOut} ${timeOut} ${timeOut}
    ''}

  xset r rate 200 30
  xrdb -merge ${config.xdg.cacheHome}/wal/colors.Xresources
  xrdb -merge ${config.xresources.path}

  [ -f ${config.home.homeDirectory}/.fehbg ] && nix-shell -p feh --command ${config.home.homeDirectory}/.fehbg

  ${
    lib.optionalString config.misc.services.dunst.enable
    "${config.services.dunst.package}/bin/dunst &"
  }
  ${
    lib.optionalString config.misc.services.picom.enable
    "${config.services.picom.package}/bin/picom --vsync -b --config ${config.misc.services.picom.configFile} &"
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
