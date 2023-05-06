{
  cfg,
  pkgs,
  ...
}: let
  bspc = "${pkgs.bspwm}/bin/bspc";
  eww = "${pkgs.eww}/bin/eww";
  flameshot = "${pkgs.flameshot}/bin/flameshot";
  bsp-layout = "${pkgs.bsp-layout}/bin/bsp-layout";
in {
  "super + shift + {q,r}" = "${bspc} {quit,wm -r}";
  "super + q" = "${bspc} node -c";
  "super + shift + b" = "${./scripts/bspwm_toggle_bar}";
  "super + Tab" = "${bspc} desktop --focus last";
  "super + shift + Return" = "${./scripts/bspwm_swap_master}";
  "super + l; {t,space,f}" = "${bspc} node -t {tiled,floating,fullscreen}";
  "super + m" = "${bspc} desktop -l next";
  "super + {j,k}" = "${bspc} node -f {next,prev}.local.!hidden.window";
  "super + {u,o}" = "${bspc} desktop -f {prev,next}.local";
  "super + {grave,Tab}" = "${bspc} {node,desktop} -f last";
  "super + {_,shift + }{1-9}" = "${bspc} {desktop -f,node -d} '^{1-9}'";
  "super + shift + {j,k,l}" = "${./scripts/bspwm_gaps} {decrease,increase,reset}";
  "super + ctrl + {h,j,k,l}" = "${./scripts/bspwm_resize} resize {left,down,up,right}";
  "super + ctrl + shift + {h,j,k,l}" = "${./scripts/bspwm_resize} contract {left, down, up, right}";
  "super + alt + {h,j,k,l}" = "${bspc} node -v {-15 0,0 15,0 -15,15 0}";
  "super + shift + space" = "${flameshot} gui -c";
  "super + comma" = ''
    if [ $(${eww} get control-panel-visible) = "true" ]; then a=false; else a=true; fi; ${eww} update control-panel-visible=$a;
  '';
  "super + period" = "${bsp-layout} next --layouts ${builtins.concatStringsSep "," cfg.enabledLayouts}";
}
