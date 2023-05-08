{
  config,
  pkgs,
  ...
}: {
  imports = [./hardware-configuration.nix ../../nixos-modules/nordvpn];

  services.locate.enable = true;
  services.nordvpn.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.kernelPackages = pkgs.linuxPackages_6_2;
  boot.tmp.cleanOnBoot = true;

  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = [config.attributes.primaryUser.name];

  time.timeZone = "Europe/Berlin";
  time.hardwareClockInLocalTime = true;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  sound.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  programs.zsh.enable = true;
  environment.pathsToLink = ["/"];
  environment.systemPackages = with pkgs; [nodejs man-pages man-pages-posix];
  documentation.dev.enable = true;

  hardware = {
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
      forceFullCompositionPipeline = true;
    };
    opengl.enable = true;
  };
  services.xserver = {
    # TODO: checkout xautolock
    enable = true;
    exportConfiguration = true;
    videoDrivers = ["nvidia"];
    layout = "us";
    xkbVariant = "altgr-intl";
    # config is managed by home-maanger
    windowManager.bspwm.enable = true;
    displayManager.gdm.enable = true;
    displayManager.defaultSession = "none+bspwm";
    libinput.enable = true;
    serverFlagsSection = ''
      Option "BlankTime" "0"
      Option "StandbyTime" "0"
      Option "SuspendTime" "0"
      Option "OffTime" "0"
      Option "DPMS" "off"
    '';
    xrandrHeads = [
      {
        output = "DP-0";
        primary = true;
      }
    ];
    resolutions = [
      {
        x = 3440;
        y = 1440;
      }
    ];
  };

  services.autorandr.enable = true;
  services.autorandr.profiles.default = {
    fingerprint.DP-0 = "00ffffffffffff004c2d45713733453023200104b55022783aee95a3544c99260f5054bfef80714f810081c081809500a9c0b3000101e77c70a0d0a0295030203a001e4e3100001a000000fd0032641e9737000a202020202020000000fc004c53333441363530550a202020000000ff00484e54543830303437330a202001fa02031bf146901f041303122309070783010000e305c000e30605014ed470a0d0a0465030203a001e4e3100001a565e00a0a0a02950302035001e4e3100001a023a801871382d40582c45001e4e3100001e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000049";
    config = {
      DP-0 = {
        enable = true;
        position = "0x0";
        dpi = 96;
        primary = true;
        mode = "3440x1440";
        rate = "99.98";
      };
    };
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
    geoclue2.enable = true;
  };

  system.stateVersion = "22.11";
}
