{
  config,
  pkgs,
  ...
}: {
  imports = [./hardware-configuration.nix ../../nixos-modules/nordvpn];

  services.locate.enable = true;
  services.nordvpn.enable = true;
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
    tmp.cleanOnBoot = true;
  };

  # speeds up boot-times
  systemd.services.NetworkManager-wait-online.enable = false;

  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = [config.attributes.primaryUser.name];

  nix = {
    # set nixpkgs in NIX_PATH to currently pinned flake input
    nixPath = ["nixpkgs=${builtins.toString pkgs.path}"];
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

  # TODO: set this up properly, maybe add sync to makeHost config
  # Also check out backup solutions such as borg-backup
  services.syncthing = let
    user = config.attributes.primaryUser.name;
  in {
    enable = true;
    openDefaultPorts = true;
    guiAddress = "127.0.0.1:8384";
    group = "users";
    inherit user;
    dataDir = "/home/${user}/.local/share/.syncthing";
  };
  # permit syncthing admin gui port
  networking.firewall.allowedTCPPorts = [8384];

  sound.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  programs.zsh.enable = true;
  programs.steam.enable = true;
  environment.pathsToLink = ["/"];
  environment.systemPackages = with pkgs; [
    gcc
    unzip
    tree
    discord
    steam-run
  ];

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-114n.psf.gz";
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
        output = "DP-4";
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

  services.autorandr = {
    enable = true;
    profiles = {
      default = {
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
