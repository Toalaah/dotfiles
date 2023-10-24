{
  config,
  pkgs,
  ...
}: {
  security.polkit.enable = true;

  services.gnome.at-spi2-core.enable = true;

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = ["graphical-session.target"];
    wants = ["graphical-session.target"];
    after = ["graphical-session.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = config.attributes.primaryUser.sshKeys != [];
    enableBrowserSocket = true;
    pinentryFlavor = "gnome3";
  };
}
