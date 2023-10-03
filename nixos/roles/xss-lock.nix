{pkgs, ...}: let
  lockScript = pkgs.writeShellScriptBin "lock-cmd" ''
    export XSECURELOCK_SHOW_DATETIME=1
    export XSECURELOCK_PASSWORD_PROMPT=time
    export XSECURELOCK_SINGLE_AUTH_WINDOW=1
    exec ${pkgs.xsecurelock}/bin/xsecurelock $@
  '';
in {
  environment.systemPackages = with pkgs; [xsecurelock];

  programs.xss-lock = {
    enable = true;
    lockerCommand = "${lockScript}/bin/lock-cmd";
    extraOptions = [
      "--notifier=${pkgs.xsecurelock}/libexec/xsecurelock/dimmer"
      "--transfer-sleep-lock"
    ];
  };

  services.xserver.serverFlagsSection = ''
    Option "BlankTime" "${builtins.toString 5}"
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
}
