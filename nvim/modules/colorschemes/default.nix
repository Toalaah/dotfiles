{lib, ...}: let
  inherit (lib.attrsets) mapAttrsToList;
  files = builtins.readDir ./.;
in {
  imports =
    mapAttrsToList (n: v: (lib.path.append ./. n))
    (builtins.removeAttrs files ["default.nix"]);
}
