{
  pkgs,
  nixos-hardware,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    nixos-hardware.nixosModules.lenovo-thinkpad-x1-10th-gen
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_6_2;
    kernelParams = ["i915.enable_psr=0"];
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
        # disable kernel command-line
        editor = false;
        consoleMode = "1";
      };
      efi.canTouchEfiVariables = true;
    };
  };

  networking.networkmanager.enable = true;

  time = {
    timeZone = "Europe/Berlin";
    hardwareClockInLocalTime = true;
  };

  sound.enable = true;

  hardware.bluetooth.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  programs.zsh.enable = true;
  environment.pathsToLink = ["/share/zsh"];

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    # TODO: console font is still tiny on hidpi display
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    packages = [pkgs.terminus_font];
    useXkbConfig = true;
    earlySetup = true;
  };

  systemd = {
    services.xsecurelock-wake-on-suspend-1 = {
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
  };

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

  services.xserver = {
    dpi = 150;
    videoDrivers = ["modesetting"];
    deviceSection = ''
      Option "DRI" "3"
      Option "TearFree" "true"
    '';
    serverFlagsSection = ''
      Option "BlankTime" "5"
    '';
    enable = true;
    layout = "us";
    xkbOptions = "ctrl:swapcaps";
    synaptics.minSpeed = 1.0;
    libinput = {
      enable = true;
      mouse.accelProfile = "flat";
      touchpad.accelProfile = "flat";
    };
    displayManager.startx.enable = true;
    xrandrHeads = [
      {
        output = "Virtual-1";
        primary = true;
        monitorConfig = ''
          Option "DPMS" "false"
        '';
      }
    ];
    resolutions = [
      {
        x = 2880;
        y = 1800;
      }
    ];
  };

  security = {
    polkit.enable = true;
    sudo = {
      enable = true;
      wheelNeedsPassword = false;
    };
  };

  services = {
    openssh.enable = true;
    unclutter.enable = true;
    fwupd.enable = true; # firmware updater
    fstrim.enable = true;
    # power optoimizations
    thermald.enable = true;
    power-profiles-daemon.enable = false;
    # TODO: move this to module
    tlp = {
      enable = true;
      settings = {
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        # Minimize number of used CPU cores/hyper-threads under light load conditions
        SCHED_POWERSAVE_ON_AC = 0;
        SCHED_POWERSAVE_ON_BAT = 1;
      };
    };
  };

  system.stateVersion = "22.11";
}
