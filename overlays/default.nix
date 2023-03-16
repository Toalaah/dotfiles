{...}: (final: prev: let
  customPkgs = import ../pkgs {pkgs = final;};
in {
})
