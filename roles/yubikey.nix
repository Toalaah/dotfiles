{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    gnupg
    yubioath-flutter
    yubikey-manager
    yubikey-personalization
  ];

  services.pcscd.enable = true;

  services.udev.packages = [pkgs.yubikey-personalization];
}
