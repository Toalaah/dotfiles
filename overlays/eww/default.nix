{prev}:
prev.eww.overrideAttrs (old: rec {
  version = "6a64a286291456984011c4fb160def106ee55dff";
  src = prev.fetchFromGitHub {
    owner = "elkowar";
    repo = "eww";
    rev = version;
    sha256 = "sha256-IliWerC9qk4MxYNRoe/8uuQZkqjPJPsph46fmVBvo9U=";
  };
  cargoDeps = old.cargoDeps.overrideAttrs (_old': {
    inherit src;
    outputHash = "sha256-K/vTAQDu8Fe/Lwr28P/sHjHVyh/5hZh7pAp2nCKfWps=";
    patches = [];
  });

  patches = [];
})
