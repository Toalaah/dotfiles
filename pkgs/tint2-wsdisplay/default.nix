{
  stdenv,
  libX11,
  pkg-config,
  lib,
  writeText,
  fetchFromGitHub,
  conf ? null,
}:
stdenv.mkDerivation {
  name = "tint2-wsdisplay";
  src = fetchFromGitHub {
    owner = "toalaah";
    repo = "tint2-wsdisplay";
    rev = "91aaffcfb709558b0d8b40b2519905b0f4c9c2f2";
    sha256 = "sha256-qZAHc6aHAlPWyMK+AQ91wcWUc7dlyAjGZLVR501ToUc=";
  };

  patches = [
    ./rows.patch
  ];

  postPatch = let
    configFile =
      if lib.isDerivation conf || builtins.isPath conf
      then conf
      else writeText "config.h" conf;
  in
    lib.optionalString (conf != null) "cp ${configFile} config.h";

  nativeBuildInputs = [pkg-config];
  buildInputs = [libX11];

  installPhase = ''
    mkdir -p $out/bin
    cp tint2-wsdisplay $out/bin/
  '';
}
