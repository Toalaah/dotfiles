{...}: (final: _prev: let
  customPkgs = import ../pkgs {pkgs = final;};
in {
  # custom package declarations
  sf-mono = customPkgs.sf-mono;
  league-mono = customPkgs.league-mono;
})
