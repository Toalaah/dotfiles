{prev, gtk-layer-shell}:
prev.eww.overrideAttrs (old: rec {
  buildInputs = old.buildInputs ++ [gtk-layer-shell];
  version = "e76206817de1cb86ec431dcff7d4b04c8b7d36fc";
  src = prev.fetchFromGitHub {
    owner = "elkowar";
    repo = "eww";
    rev = version;
    sha256 = "sha256-7zN4FWGFpHo3SCe/c5ximxbQyikY8nUBgp+QHUkGsFQ=";
  };
  cargoDeps = old.cargoDeps.overrideAttrs (_old': {
    inherit src;
    outputHash = "sha256-ereoJ2SdnMeX/s1DPklBHxUsFmD7RM9Mt/9DG2HQk5E=";
    patches = [];
  });

  patches = [];
})
