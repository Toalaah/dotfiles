{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../nixos/modules

    ../../nixos/profiles/gpg-auth-agent
    ../../nixos/profiles/graphical

    ../../roles/tor.nix
    ../../roles/nfs.nix
    ../../roles/nvidia.nix
    ../../roles/docker.nix
    ../../roles/nix.nix
    ../../roles/libvirt.nix
    ../../roles/sudo.nix
    ../../roles/ssh.nix
    ../../roles/vpn.nix
    ../../roles/networking.nix
    ../../roles/locale.nix
  ];

  security.pass.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.kernelPackages = pkgs.linuxPackages_6_4;
  boot.tmp.cleanOnBoot = true;

  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    adapta-gtk-theme
    gnome3.adwaita-icon-theme
    hicolor-icon-theme
    networkmanagerapplet
    nodejs
    xorg.xcursorthemes
  ];

  security.yubikey = {
    enable = true;
    id = config.attributes.primaryUser.smartcard.id;
    pam.enable = false;
  };

  graphical.xorg.enable = true;
  graphical.xorg.windowManager = "bspwm";
  hardware.nvidia.nvidiaPersistenced = true;
  hardware.nvidia.forceFullCompositionPipeline = true;
  graphical.xorg.screenLocker.enable = true;
  hardware.opengl.driSupport32Bit = true;
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "altgr-intl";
  graphical.xorg.settings = {
    videoDrivers = ["nvidia"];
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

  services.unclutter.enable = true;
  services.geoclue2.enable = true;
  services.locate.enable = true;

  system.stateVersion = "22.11";
}
