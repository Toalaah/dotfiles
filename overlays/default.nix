{...}: (final: prev: let
  customPkgs = import ../pkgs {pkgs = final;};
in {
  # custom package declarations
  sf-mono = customPkgs.sf-mono;
  league-mono = customPkgs.league-mono;
  # TODO: remove this once package is upstreamed, pr no.: #220616
  nordvpn = customPkgs.nordvpn;
})
