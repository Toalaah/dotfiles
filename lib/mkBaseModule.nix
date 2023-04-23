{hostname}: {
  config,
  lib,
  pkgs,
  ...
}: let
  user = config.attributes.primaryUser;
in {
  # always need at least one user who is defined via attributes option-set
  imports = [../home/users/attributes.nix];
  # prevent hostname from being accidentally overwritten in other modules
  networking.hostName = lib.mkForce hostname;
  users.mutableUsers = true;
  i18n = {
    defaultLocale = user.locale;
    supportedLocales = ["all"];
  };
  users.users."${user.name}" = {
    isNormalUser = true;
    uid = 1000;
    shell = user.shell;
    description = user.fullName;
    extraGroups = ["wheel" "video" "audio"] ++ user.additionalGroups;
    openssh.authorizedKeys.keys = user.sshKeys;
  };
  environment.systemPackages = [
    pkgs.cached-nix-shell
    # override nix-shell builtin with cached implementation. this allows for
    # using nix-shell in script shebangs while retaining caching functionality,
    # making scripts more portable.
    (pkgs.symlinkJoin {
      name = "nix-shell";
      paths = [pkgs.cached-nix-shell];
      postBuild = ''
        ln -s $out/bin/cached-nix-shell $out/bin/nix-shell
        ln -s $out/share/man/man1/cached-nix-shell.1.gz $out/share/man/man1/nix-shell.1.gz
        mkdir -p $out/share/nix-shell
        ln -s $out/share/cached-nix-shell/rcfile.sh $out/share/nix-shell/rcfile.sh
      '';
    })
  ];

  programs.bash.interactiveShellInit = lib.optionalString (user.shell == pkgs.zsh) ''
    if [ ! -z ''${SIMPLE_ZSH_NIX_SHELL_BASH+x} ] ;
      then source $SIMPLE_ZSH_NIX_SHELL_BASH
    fi
  '';
}
