{hostname}: {
  config,
  lib,
  ...
}: let
  user = config.attributes.primaryUser;
in {
  # always need at least one user who is defined via attributes option-set
  imports = [../home/attributes.nix];
  # prevent hostname from being accidentally overwritten in other modules
  networking.hostName = lib.mkForce hostname;
  # users.mutableUsers = false;
  users.users."${user.name}" = {
    isNormalUser = true;
    uid = 1000;
    shell = user.shell;
    extraGroups = ["wheel" "video" "audio"] ++ user.additionalGroups;
  };
}