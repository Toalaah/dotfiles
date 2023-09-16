{...}: (
  final: _prev: let
    customPkgs = import ../pkgs {pkgs = final;};
  in
    # custom package declarations
    customPkgs
    # any other overlays go here
    // {}
)
