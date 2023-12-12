{
  pkgs,
  gulp,
  ...
}: {
  imports = [
    gulp.nixosModules.default
  ];
  services.gulp.enable = true;
  services.xserver = {
    enable = true;
    layout = "us";
    exportConfiguration = true;
    displayManager.gdm.enable = true;
    autoRepeatDelay = 300;
    autoRepeatInterval = 30;
    libinput.enable = true;
    libinput.mouse.accelProfile = "flat";
    libinput.touchpad.accelProfile = "flat";
    synaptics.minSpeed = 1.0;
  };
  hardware.opengl.enable = true;
  environment.systemPackages = [pkgs.xclip];
  services.picom = {
    enable = true;
    shadow = false;
    vSync = true;
    shadowOpacity = 0.6;
    settings = {
      frame-opacity = 0.7;
      # inactive-opacity-override = false;
      # wm-ignore = false;
    };
  };
}
