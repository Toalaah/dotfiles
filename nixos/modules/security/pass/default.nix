{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.security.pass;
  gen-passphrase = pkgs.writeShellScriptBin "gen-passphrase" ''
    set -e

    if [ -z "$1" ]; then
      echo "Usage: $0 <name> [<opts>]"
      echo
      ${pkgs.pass-gen}/bin/pass-gen --help 2>&1 | ${pkgs.busybox}/bin/grep -A 9999 -e 'Options'
      exit 1
    fi

    ${pkgs.pass-gen}/bin/pass-gen -e "''${@:2}" | pass add -e "$1"
  '';
in {
  options.security.pass.enable = mkEnableOption "password management / generation utilities";
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      pass
      pass-gen
      gen-passphrase
    ];
  };
}
