{
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation {
  pname = "pass-gen";
  version = "0.5.0";
  patches = [./prefix.patch ./wordlist-dir.patch];
  src = fetchFromGitHub {
    owner = "codesections";
    repo = "pass-gen";
    # newer rev than 0.5.0 tag
    rev = "b4ce2fe74d93fad14914acf44542ae3aa70635f7";
    sha256 = "sha256-ys2Kv89gCYJFeJ7l+JjCF2MD2v2VuuXl55I4qfrnu70=";
  };

  dontBuild = true;
  installFlags = ["PREFIX=$(out)"];
  postPatch = ''
    substituteInPlace pass-gen \
      --replace "@out@" "$out"
  '';
}
