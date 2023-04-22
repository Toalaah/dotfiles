{hostname}: {
  config,
  lib,
  pkgs,
  ...
}: let
  user = config.attributes.primaryUser;
in {
  # always need at least one user who is defined via attributes option-set
  imports = [../home/users/attributes.nix];
  # prevent hostname from being accidentally overwritten in other modules
  networking.hostName = lib.mkForce hostname;
  users.mutableUsers = true;
  i18n = {
    defaultLocale = user.locale;
    supportedLocales = ["all"];
  };
  users.users."${user.name}" = {
    isNormalUser = true;
    uid = 1000;
    shell = user.shell;
    description = user.fullName;
    extraGroups = ["wheel" "video" "audio"] ++ user.additionalGroups;
    openssh.authorizedKeys.keys = user.sshKeys;
  };
  environment.systemPackages = [pkgs.cached-nix-shell];
}
