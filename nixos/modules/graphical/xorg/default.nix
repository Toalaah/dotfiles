{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.graphical.xorg;
  windowManagers = ["bspwm"];
in {
  options.graphical.xorg = {
    enable = mkEnableOption "xorg graphical session infrastructure";
    screenLocker = {
      enable = mkEnableOption "screen-locker";
      timeOut = mkOption {
        type = types.ints.positive;
        default = 5;
        description = "time to wait before locking the session, in minutes";
      };
    };
    windowManager = mkOption {
      type = types.enum windowManagers;
      description = "window manager to set as default session";
      default = "bspwm";
    };
    settings = {
      inherit (options.services.xserver) dpi videoDrivers xrandrHeads resolutions deviceSection serverFlagsSection xkbOptions;
    };
  };
  config = mkMerge [
    (mkIf cfg.enable {
      hardware.opengl.enable = true;
      services.xserver = {
        enable = true;

        inherit (cfg.settings) dpi videoDrivers xrandrHeads resolutions deviceSection serverFlagsSection xkbOptions;
        exportConfiguration = true;

        displayManager.gdm.enable = true;

        layout = "us";

        autoRepeatDelay = 300;
        autoRepeatInterval = 30;

        libinput.enable = true;
        libinput.mouse.accelProfile = "flat";
        libinput.touchpad.accelProfile = "flat";

        synaptics.minSpeed = 1.0;
      };

      environment.systemPackages = [pkgs.xclip];
    })

    (mkIf (cfg.enable && cfg.windowManager == "bspwm") {
      services.xserver.windowManager.bspwm.enable = true;
      services.xserver.displayManager.defaultSession = "none+bspwm";
    })

    (mkIf (cfg.enable && cfg.screenLocker.enable) {
      environment.systemPackages = [pkgs.xsecurelock];

      programs.xss-lock = {
        enable = true;
        extraOptions = [
          "--notifier=${pkgs.xsecurelock}/libexec/xsecurelock/dimmer"
          "--transfer-sleep-lock"
        ];
        lockerCommand = let
          lockScript = pkgs.writeShellScriptBin "lock-cmd" ''
            export XSECURELOCK_SHOW_DATETIME=1
            export XSECURELOCK_PASSWORD_PROMPT=time
            export XSECURELOCK_SINGLE_AUTH_WINDOW=1
            exec ${pkgs.xsecurelock}/bin/xsecurelock $@
          '';
        in "${lockScript}/bin/lock-cmd";
      };

      services.xserver.serverFlagsSection = ''
        Option "BlankTime" "${builtins.toString cfg.screenLocker.timeOut}"
      '';

      systemd.services.xsecurelock-wake-on-suspend-1 = {
        description = "automatically show lockscreen prompt on wakeup";
        after = [
          "suspend.target"
          "hibernate.target"
          "hybrid-sleep.target"
          "suspend-then-hibernate.target"
        ];
        script = ''
          [[ "$1" = "post" ]] && pkill -x -USR2 xsecurelock
          exit 0
        '';
      };
    })
  ];
}
