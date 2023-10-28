{nixpkgs}: {
  hostname,
  system ? "x86_64-linux",
  primaryUser,
  overlays ? [],
  specialArgs ? {},
  useHomeManager ? true,
  config ? {},
  roles ? [],
}: let
  pkgs = import nixpkgs {
    inherit system overlays config;
  };
  baseModule = import ./mkBaseModule.nix {inherit hostname;};
  userModule = primaryUser.attributes;
  hostModule = ../nixos/hosts/${hostname};
in
  nixpkgs.lib.nixosSystem {
    inherit pkgs system specialArgs;
    modules =
      [
        baseModule
        hostModule
        userModule
      ]
      ++ (builtins.map (
          r: let
            inherit (nixpkgs.lib) pathExists path;
            pathMaybeDir = path.append ../nixos/roles r;
            pathMaybeFile = path.append ../nixos/roles "${r}.nix";
          in
            if pathExists pathMaybeDir
            then pathMaybeDir
            else if pathExists pathMaybeFile
            then pathMaybeFile
            else throw "Could not import role '${r}'"
        )
        roles)
      ++ pkgs.lib.optional useHomeManager (
        {
          config,
          home-manager,
          ...
        }: let
          user = config.attributes.primaryUser;
        in {
          imports = [specialArgs.home-manager.nixosModule];
          nix.registry.home-manager.flake = home-manager;
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = specialArgs;
            users.${user.name} = import primaryUser.homeConfig;
          };
        }
      );
  }
