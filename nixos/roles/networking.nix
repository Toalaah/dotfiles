{pkgs, ...}: {
  networking.firewall.allowPing = true;
  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    dnsutils
    netcat-openbsd
    tcpdump
    traceroute
  ];
}
