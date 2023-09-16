{pkgs}: {
  sf-mono = pkgs.callPackage ./sf-mono {};
  league-mono = pkgs.callPackage ./league-mono {};
  pass-gen = pkgs.callPackage ./pass-gen {};
}
