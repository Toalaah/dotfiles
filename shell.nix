{pkgs}:
with pkgs;
  mkShell {
    buildInputs = [
      alejandra
      deadnix
      git-crypt
      just
    ];
  }
