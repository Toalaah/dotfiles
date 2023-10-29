{pkgs, ...}: let
  mirror = "https://ftp.nluug.nl/pub/vim/runtime/spell/";
  files = [
    {
      name = "en.utf-8.spl";
      sha256 = "sha256-/sq9yUm2o50ywImfolReqyXmPy7QozxK0VEUJjhNMHA=";
    }
    {
      name = "de.utf-8.spl";
      sha256 = "sha256-c8cQfqM5hWzb6SHeuSpFk5xN5uucByYdobndGfaDo9E=";
    }
  ];
  mkSpellSource = src:
    pkgs.fetchurl {
      url = "${mirror}/${src.name}";
      inherit (src) sha256;
    };
  sources = builtins.map mkSpellSource files;
  spell = pkgs.runCommand "spell" {} ''
    mkdir $out
    ${
      builtins.concatStringsSep "\n" (builtins.map (x: ''
          cp ${x} $out
        '')
        sources)
    }
    for f in $out/*; do
      basename="$(basename $f | cut -c 34-)"
      mv $f $out/$basename
    done
  '';
in {
  rtp = [spell.outPath];
  postHooks = ''
    vim.cmd [[set spelllang=en_us,de_de ]]
  '';
}
