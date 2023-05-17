{
  config,
  nixos-hardware,
  pkgs,
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

  boot.kernelPackages = pkgs.linuxPackages_6_2;
  boot.tmp.cleanOnBoot = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;
  };

  hardware.bluetooth.enable = true;

  # fingerprint support
  services.fprintd.enable = true;
  services.fprintd.package = pkgs.fprintd-tod;
  services.fprintd.tod.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-vfs0090;

  services.nordvpn.enable = true;

  environment.systemPackages = with pkgs; [
    virt-manager
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

  graphical.xorg.enable = true;
  graphical.xorg.windowManager = "bspwm";
  graphical.xorg.screenLocker.enable = true;
  graphical.xorg.settings = {
    videoDrivers = ["modesetting"];
    xrandrHeads = [
      {
        output = "Virtual-1";
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
