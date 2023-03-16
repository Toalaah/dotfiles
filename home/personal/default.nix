{
  config,
  pkgs,
  ...
}: let
  user = config.attributes.primaryUser;
in {
  imports = [../attributes.nix ./secrets];
  xresources.properties."Xft.dpi" = 144;
  home = {
    username = user.name;
    homeDirectory = "/home/${user.name}";
    stateVersion = "22.11";
  };
}
