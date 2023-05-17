{pkgs, ...}: {
  environment.systemPackages = [pkgs.batsignal];
  systemd.services.batsignal = {
    description = "Battery monitor daemon";
    wantedBy = ["default.target"];
    documentation = ["man:batsignal(1)"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.batsignal}/bin/batsignal";
      Restart = "on-failure";
      RestartSec = 1;
    };
  };
}
