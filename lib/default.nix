{nixpkgs}: {
  makeHost = import ./makeHost.nix {inherit nixpkgs;};
  makeHomeConfigurations = import ./makeHomeConfigurations.nix {inherit nixpkgs;};
}
