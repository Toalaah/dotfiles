{nixpkgs}: {
  home-manager,
  users,
}: let
  lib = nixpkgs.lib;
  getUsernameFor = x: let
    # pkgs does not need to be valid when querying simple attributes such as
    # username, see attributes.nix file in home/users
    data = import x.user.attributes {pkgs = null;};
  in
    data.attributes.primaryUser.name;
  makeHomeConfigurationFor = user:
    home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        inherit (user) system overlays;
        config = user.config or {};
      };
      modules = [
        user.user.homeConfig
        ({pkgs, ...}: {home.packages = [pkgs.cached-nix-shell];})
      ];
      extraSpecialArgs = user.specialArgs;
    };
in
  lib.mapAttrs' (_: user:
    lib.nameValuePair (getUsernameFor user) (makeHomeConfigurationFor user))
  users
