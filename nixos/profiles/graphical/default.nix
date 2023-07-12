{pkgs, ...}: {
  sound.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
  environment.systemPackages = [pkgs.pavucontrol];
}
