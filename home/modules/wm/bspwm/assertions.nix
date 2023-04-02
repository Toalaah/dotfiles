{
  config,
  cfg,
  bspwm,
}: [
  {
    assertion = config.attributes.primaryUser.windowManager == bspwm;
    message = "foo";
  }
  {
    assertion = config.wm.sxhkd.enable;
    message = "sxhkd must be enabled";
  }
  {
    assertion = (cfg.statusBar == "eww") -> config.wm.eww.enable;
    message = "eww must be enabled";
  }
]
