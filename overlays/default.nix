{...}: (final: prev: let
  customPkgs = import ../pkgs {pkgs = final;};
in {
  # custom package declarations
  sf-mono = customPkgs.sf-mono;
  league-mono = customPkgs.league-mono;

  # nixpkgs overlays
  eww = final.callPackage ./eww {inherit prev;};
})
