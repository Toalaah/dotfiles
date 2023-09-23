{
  config,
  lib,
  pkgs,
  ...
}: {
  options.environment.enableBinBash = lib.mkEnableOption "Include /bin/bash in the system" // {default = true;};

  config = {
    system.activationScripts.binbash =
      if config.environment.enableBinBash
      then ''
        mkdir -m 0755 -p /bin
        ln -sfn ${pkgs.bashInteractive}/bin/bash /bin/.bash.tmp
        mv /bin/.bash.tmp /bin/bash # atomically replace /bin/bash
      ''
      else ''
        rm -f /bin/bash
        rmdir -p /bin || true
      '';
  };
}
