{pkgs}: let
  allPackages = builtins.removeAttrs (builtins.readDir ./.) ["default.nix"];
  mapToDerivation = pkgName: _: pkgs.callPackage ./${pkgName} {};
in
  builtins.mapAttrs mapToDerivation allPackages
