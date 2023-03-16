{stdenv}:
stdenv.mkDerivation {
  name = "fonts-league-mono";
  src = builtins.fetchurl {
    url = "https://github.com/theleagueof/league-mono/releases/download/2.300/LeagueMono-2.300.tar.xz";
    sha256 = "03fgzl1b6fhg3yq62jik2ziirylcbb8i3frg7hx81cayma1wkg8n";
  };
  installPhase = ''
    mkdir -p $out/share/fonts/opentype/League\ Mono
    mkdir -p $out/share/fonts/truetype/League\ Mono
    mv static/OTF/* $out/share/fonts/opentype/League\ Mono
    mv static/TTF/* $out/share/fonts/truetype/League\ Mono
  '';
}
