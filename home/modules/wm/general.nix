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
        default = "${pkgs.xss-lock}/bin/xss-lock ${../sxhkd/scripts/lock-screen} &";
        description = "command to lock the screen";
      };
      timeout = mkOption {
        type = types.int;
        default = 300;
        description = "time in seconds after which the screen will be locked";
      };
    };
  };

  config = mkMerge [
    (mkIf (cfg.displayManager == "xinit") {
      assertions = [
        {
          assertion = currentWindowManager != null;
          message = "a window manager / desktop environment must be specified";
        }
      ];
      home.file.".xinitrc".text = ''
        exec ${currentWindowManager}
      '';
    })
  ];
}
