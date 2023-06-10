{
  config,
  nixos-hardware,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    nixos-hardware.nixosModules.lenovo-thinkpad-x1-10th-gen
    ../../nixos/modules

    ../../nixos/profiles/gpg-auth-agent
    ../../nixos/profiles/graphical
    ../../nixos/profiles/laptop
    ../../nixos/profiles/hidpi
    ../../nixos/profiles/libvirt
  ];

  networking.nameservers = ["1.1.1.1" "8.8.8.8"];
  boot.kernelPackages = pkgs.linuxPackages_6_3;
  boot.kernelParams = ["i915.enable_psr=0"];
  boot.kernelModules = ["i915"];
  boot.tmp.cleanOnBoot = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # fingerprint support
  services.fprintd.enable = true;
  services.fprintd.package = pkgs.fprintd-tod;
  services.fprintd.tod.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-vfs0090;

  # enable intel mipi camera
  hardware.ipu6.enable = true;
  hardware.ipu6.platform = "ipu6ep";

  services.nordvpn.enable = true;

  environment.systemPackages = with pkgs; [
    autorandr
    virt-manager
    bluetuith
    anki
    (pkgs.writeShellScriptBin "nm-gui" ''
      #!/bin/sh
      set +x
      ${pkgs.networkmanagerapplet}/bin/nm-applet &
      pid=$!
      ${pkgs.stalonetray}/bin/stalonetray
      kill -9 $pid
    '')
  ];

  environment.etc."X11/xorg.conf.d/00-keyboard.conf".text = lib.mkForce ''
    Section "InputClass"
      Identifier "Keyboard catchall"
      MatchDevicePath "/dev/input/event1"
      Option "XkbModel" "pc104"
      Option "XkbLayout" "us"
      Option "XkbOptions" "ctrl:swapcaps"
      Option "XkbVariant" "altgr-intl"
    EndSection
  '';

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
  };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "altgr-intl";
  graphical.xorg.enable = true;
  graphical.xorg.windowManager = "bspwm";
  graphical.xorg.screenLocker.enable = true;
  graphical.xorg.settings = {
    videoDrivers = ["modesetting"];
    xrandrHeads = [
      {
        output = "eDP-1";
        primary = true;
      }
    ];
    resolutions = [
      {
        x = 1920;
        y = 1200;
      }
    ];
    deviceSection = ''
      Option "DRI" "3"
      Option "TearFree" "true"
    '';
    xkbOptions = "ctrl:swapcaps";
  };

  services.autorandr.enable = true;
  services.autorandr.profiles.mobile = {
    fingerprint.eDP-1 = "00ffffffffffff004c83524100000000231e0104b51e1378020cf1ae523cb9230c505400000001010101010101010101010101010101a4c34050b0085070082088002ebd1000001ba4c34050b008fc73082088002ebd1000001b0000000f00ff0a5aff0a3c28800000000000000000fe0041544e413430594b30312d312001a702030f00e3058000e606050174600700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b7";
    config = {
      eDP-1 = {
        enable = true;
        position = "0x0";
        dpi = 96;
        primary = true;
        mode = "1920x1200";
        rate = "59.95";
      };
    };
  };
  services.autorandr.profiles.clamshell-docked = {
    fingerprint.DP-3 = "00ffffffffffff004c2d45713733453023200104b55022783aee95a3544c99260f5054bfef80714f810081c081809500a9c0b3000101e77c70a0d0a0295030203a001e4e3100001a000000fd0032641e9737000a202020202020000000fc004c53333441363530550a202020000000ff00484e54543830303437330a202001fa02031bf146901f041303122309070783010000e305c000e30605014ed470a0d0a0465030203a001e4e3100001a565e00a0a0a02950302035001e4e3100001a023a801871382d40582c45001e4e3100001e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000049";
    fingerprint.eDP-1 = "00ffffffffffff004c83524100000000231e0104b51e1378020cf1ae523cb9230c505400000001010101010101010101010101010101a4c34050b0085070082088002ebd1000001ba4c34050b008fc73082088002ebd1000001b0000000f00ff0a5aff0a3c28800000000000000000fe0041544e413430594b30312d312001a702030f00e3058000e606050174600700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b7";
    config = {
      eDP-1.enable = false;
      DP-3 = {
        enable = true;
        position = "0x0";
        dpi = 96;
        primary = true;
        mode = "3440x1440";
        rate = "99.98";
      };
    };
  };

  # custom per-host home-manager overrides
  home-manager.users.${config.attributes.primaryUser.name} = {
    config,
    lib,
    ...
  }: {
    imports = [../../home/modules];
    xresources.properties."Xft.dpi" = 96;
    terminals.alacritty.enable = true;
    terminals.st.enable = lib.mkForce false;
  };

  system.stateVersion = "22.11";
}
