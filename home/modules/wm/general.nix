{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.wm.general;
  currentWindowManager = config.attributes.primaryUser.windowManager;
in {
  options.wm.general = {
    displayManager = mkOption {
      type = types.enum ["xinit"];
      default = "xinit";
      description = "display manager to use";
    };
    screenLock = {
      enable = mkEnableOption "screen locking";
      command = mkOption {
        type = types.str;
        default = "${pkgs.xss-lock}/bin/xss-lock ${../tools/binscripts/scripts/lock-screen} &";
        description = "command to lock the screen";
      };
      timeout = mkOption {
        type = types.int;
        default = 300;
        description = "time in seconds after which the screen will be locked";
      };
    };
  };

  config = let
    xsession = "${config.home.homeDirectory}/.xsession";
  in
    mkMerge [
      (mkIf (cfg.displayManager == "xinit")
        {
          assertions = [
            {
              assertion = currentWindowManager != null;
              message = "a window manager / desktop environment must be specified";
            }
          ];
          # allows using xinitrc / sxrc
          home.file.".xinitrc".source = config.lib.file.mkOutOfStoreSymlink xsession;
          xdg.configFile."sx/sxrc".source = config.lib.file.mkOutOfStoreSymlink xsession;
        })
    ];
}
