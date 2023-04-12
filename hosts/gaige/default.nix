{
  config,
  pkgs,
  ...
}: {
  imports = [./hardware-configuration.nix];

  boot = {
    kernelPackages = pkgs.linuxPackages_6_2;
    loader = {
      timeout = 0;
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
    nixPath = [
      "nixpkgs=${builtins.toString pkgs.path}"
    ];
    package = pkgs.nixFlakes;
    settings = {
      keep-outputs = true;
      keep-derivations = true;
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
    gc.automatic = false;
  };

  networking.networkmanager.enable = true;

  time = {
    timeZone = "Europe/Berlin";
    hardwareClockInLocalTime = true;
  };

  sound.enable = true;

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

  hardware = {
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
      forceFullCompositionPipeline = true;
    };
    opengl.enable = true;
  };
  services.xserver = {
    enable = true;
    # dpi = 150;
    videoDrivers = ["nvidia"];
    layout = "us";
    displayManager.startx.enable = true;
    # xrandrHeads = [
    #   {
    #     output = "DP-4";
    #     primary = true;
    #   }
    # ];
  };

  services.autorandr = {
    enable = true;
    profiles = rec {
      default = my;
      my = {
        fingerprint = {
          DP-4 = "00ffffffffffff004c2d45713733453023200104b55022783aee95a3544c99260f5054bfef80714f810081c081809500a9c0b3000101e77c70a0d0a0295030203a001e4e3100001a000000fd0032641e9737000a202020202020000000fc004c53333441363530550a202020000000ff00484e54543830303437330a202001fa02031bf146901f041303122309070783010000e305c000e30605014ed470a0d0a0465030203a001e4e3100001a565e00a0a0a02950302035001e4e3100001a023a801871382d40582c45001e4e3100001e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000049";
        };
        config = {
          DP-4 = {
            enable = true;
            position = "0x0";
            dpi = 96;
            primary = true;
            mode = "3440x1440";
            rate = "99.98";
          };
        };
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
