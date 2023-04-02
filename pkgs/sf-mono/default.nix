{
  stdenv,
  undmg,
  p7zip,
}:
stdenv.mkDerivation {
  name = "fonts-sf-mono";
  src = builtins.fetchurl {
    url = "https://devimages-cdn.apple.com/design/resources/download/SF-Mono.dmg";
    sha256 = "0fdcras7y7cvym6ahhgn7ih3yfkkhr9s6h5b6wcaw5svrmi6vbxb";
  };
  unpackPhase = ''
    undmg $src
    7z x 'SF Mono Fonts.pkg'
    7z x 'Payload~'
  '';
  buildInputs = [undmg p7zip];
  setSourceRoot = "sourceRoot=`pwd`";
  installPhase = ''
    mkdir -p $out/share/fonts/opentype/SF\ Mono
    mkdir -p $out/share/fonts/truetype/SF\ Mono
    find -name \*.otf -exec mv {} $out/share/fonts/opentype/SF\ Mono \;
    find -name \*.ttf -exec mv {} $out/share/fonts/truetype/SF\ Mono \;
  '';
}
