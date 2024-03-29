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
  networking.firewall.allowPing = true;
  networking.networkmanager.enable = true;

  # nix.channel.enable = false;
  # set nixpkgs in NIX_PATH to currently pinned flake input
  environment.etc.nixpkgs.source = builtins.toString pkgs.path;
  nix.nixPath = ["nixpkgs=/etc/nixpkgs"];
  # make nixpkgs registry use current flake input
  nix.registry.nixpkgs.flake = nixpkgs;
  nix.package = pkgs.nixFlakes;
  nix.settings = {
    keep-outputs = true;
    keep-derivations = true;
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
  };

  users.mutableUsers = true;

  i18n = let
    locale = user.locale;
  in {
    defaultLocale = locale;
    supportedLocales = ["all"];
    extraLocaleSettings = {
      LC_ADDRESS = locale;
      LC_IDENTIFICATION = locale;
      LC_MEASUREMENT = "de_DE.UTF-8"; # metric
      LC_MONETARY = locale;
      LC_NAME = locale;
      LC_NUMERIC = locale;
      LC_PAPER = locale;
      LC_TELEPHONE = locale;
      LC_TIME = locale;
    };
  };

  users.users."${user.name}" = {
    isNormalUser = true;
    uid = 1000;
    shell = user.shell;
    description = user.fullName;
    extraGroups = ["wheel"] ++ user.additionalGroups;
    openssh.authorizedKeys.keys = user.sshKeys;
  };

  security.sudo.enable = true;
  security.sudo.extraConfig = ''
    Defaults timestamp_timeout=30
    Defaults timestamp_type=global
  '';
  security.sudo.wheelNeedsPassword = true;
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
    dnsutils
    file
    fx
    gcc
    gnumake
    gnutar
    jq
    man-pages
    man-pages-posix
    ncdu
    netcat-openbsd
    nix-shell-override
    psmisc
    tldr
    pciutils
    python3
    tcpdump
    traceroute
    tree
    unzip
    wget
    xxd
    zip
  ];

  environment.pathsToLink = ["/"];

  documentation.enable = true;
  documentation.man.enable = true;

  programs.zsh.enable = true;
  programs.bash.interactiveShellInit = lib.optionalString (user.shell == pkgs.zsh) ''
    if [ ! -z ''${SIMPLE_ZSH_NIX_SHELL_BASH+x} ] ;
      then source $SIMPLE_ZSH_NIX_SHELL_BASH
    fi
  '';

  # TOFU
  programs.ssh.knownHosts = {
    "github.com" = {
      hostNames = ["github.com"];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
    };
    "gitlab.com" = {
      hostNames = ["gitlab.com"];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAfuCHKVTjquxvt6CM6tdG4SLp1Btn/nOeHHE5UOzRdf";
    };
  };

  time.timeZone = user.timeZone;
  time.hardwareClockInLocalTime = lib.mkDefault true;

  # convenient little oneliner to print system changes on rebuilds
  system.activationScripts.diff = ''
    if [[ -e /run/current-system ]]; then
      ${pkgs.nix}/bin/nix --extra-experimental-features nix-command store diff-closures /run/current-system "$systemConfig"
    fi
  '';
}
