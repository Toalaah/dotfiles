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

  nix = {
    # set nixpkgs in NIX_PATH to currently pinned flake input
    nixPath = [("nixpkgs=" + builtins.toString pkgs.path)];
    package = pkgs.nixFlakes;
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      experimental-features = nix-command flakes
    '';
    settings.auto-optimise-store = true;
    gc.automatic = false;
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

  environment.pathsToLink = ["/share/zsh"];
  # TODO: really no reason to never not use cached-nix-shell. in this sense it
  # may be wise to expose this as a toggleable option in top-level makeHost fn
  environment.systemPackages = with pkgs; [cached-nix-shell];

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    # TODO: console font is still tiny on hidpi display
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    packages = [pkgs.terminus_font];
    useXkbConfig = true;
    earlySetup = true;
  };

  services.xserver = {
    dpi = 150;
    videoDrivers = ["modesetting"];
    deviceSection = ''
      Option "DRI" "3"
      Option "TearFree" "true"
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
