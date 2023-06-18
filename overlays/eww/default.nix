{
  prev,
  gtk-layer-shell,
  libdbusmenu,
  libdbusmenu-gtk3,
}:
prev.eww.overrideAttrs (old: rec {
  buildInputs = old.buildInputs ++ [gtk-layer-shell libdbusmenu libdbusmenu-gtk3];
  version = "e76206817de1cb86ec431dcff7d4b04c8b7d36fc";
  src = let
    rev = "tray-3";
  in
    prev.fetchFromGitHub {
      version = rev;
      owner = "ralismark";
      repo = "eww";
      inherit rev;
      sha256 = "sha256-o38cXPG296Ojyg7QN4SyVg4HqdO1s8Y1Pei4N5PcMGo=";
    };
  cargoDeps = old.cargoDeps.overrideAttrs (_old': {
    inherit src;
    outputHash = "sha256-NHexJbHJ2kK8AJF1fcUa1O6SA60h11vQcs/OSSq2Ja0=";
    patches = [];
  });

  patches = [];
})
