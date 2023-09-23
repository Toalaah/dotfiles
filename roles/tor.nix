{pkgs, ...}: {
  services.tor = {
    enable = true;
    client.enable = true;
    torsocks.enable = true;
  };

  environment.systemPackages = [pkgs.tor-browser-bundle-bin];
}
