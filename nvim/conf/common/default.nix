{lib, ...}: let
  inherit (lib.attrsets) mapAttrsToList;
  files = builtins.readDir ./.;
in {
  imports =
    mapAttrsToList (n: v: lib.path.append ./. n)
    (lib.attrsets.filterAttrs (n: v: v != "directory")
      (builtins.removeAttrs files ["default.nix"]));
}
