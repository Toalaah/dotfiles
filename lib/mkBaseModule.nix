{hostname}: {
  config,
  lib,
  pkgs,
  nixpkgs,
  ...
}: let
  user = config.attributes.primaryUser;
in {
  # always need at least one user who is defined via attributes option-set
  imports = [../home/users/attributes.nix];

  # prevent hostname from being accidentally overwritten in other modules
  networking.hostName = lib.mkForce hostname;

  users.mutableUsers = true;
  users.users."${user.name}" = {
    isNormalUser = true;
    uid = 1000;
    shell = user.shell;
    description = user.fullName;
    extraGroups = ["wheel"] ++ user.additionalGroups;
    openssh.authorizedKeys.keys = user.sshKeys;
  };

  environment.shellInit = ''
    umask 077
  '';

  environment.binbash = "${pkgs.bashInteractive}/bin/bash";

  environment.systemPackages = with pkgs; let
    # override nix-shell builtin with cached implementation. this allows for
    # using nix-shell in script shebangs while retaining caching functionality,
    # making scripts more portable.
    nix-shell-override = pkgs.symlinkJoin {
      name = "nix-shell";
      paths = [pkgs.cached-nix-shell];
      postBuild = ''
        ln -s $out/bin/cached-nix-shell $out/bin/nix-shell
        ln -s $out/share/man/man1/cached-nix-shell.1.gz $out/share/man/man1/nix-shell.1.gz
        mkdir -p $out/share/nix-shell
        ln -s $out/share/cached-nix-shell/rcfile.sh $out/share/nix-shell/rcfile.sh
      '';
    };
  in [
    # some basic packages you would expect to find on a new system
    cached-nix-shell
    file
    fx
    gcc
    gnumake
    gnutar
    jq
    man-pages
    man-pages-posix
    ncdu
    nix-shell-override
    psmisc
    tldr
    pciutils
    python3
    tree
    unzip
    wget
    xxd
    zip
  ];

  environment.pathsToLink = ["/"];

  programs.zsh.enable = true;
  programs.bash.interactiveShellInit = lib.optionalString (user.shell == pkgs.zsh) ''
    if [ ! -z ''${SIMPLE_ZSH_NIX_SHELL_BASH+x} ] ;
      then source $SIMPLE_ZSH_NIX_SHELL_BASH
    fi
  '';

  time.timeZone = user.timeZone;
  time.hardwareClockInLocalTime = lib.mkDefault true;

  # convenient little oneliner to print system changes on rebuilds
  system.activationScripts.diff = ''
    if [[ -e /run/current-system ]]; then
      ${pkgs.nix}/bin/nix --extra-experimental-features nix-command store diff-closures /run/current-system "$systemConfig"
    fi
  '';
}
