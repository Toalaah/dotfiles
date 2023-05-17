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
  networking.useDHCP = false;
  networking.useNetworkd = true;

  systemd.services.NetworkManager-wait-online.enable = false;
  systemd.network.wait-online.enable = false;
  systemd.services.systemd-networkd.stopIfChanged = false;
  systemd.services.systemd-resolved.stopIfChanged = false;

  # set nixpkgs in NIX_PATH to currently pinned flake input
  nix.nixPath = ["nixpkgs=${builtins.toString pkgs.path}"];
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
    defaultLocale = user.locale;
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
    extraGroups = ["wheel" "video" "audio"] ++ user.additionalGroups;
    openssh.authorizedKeys.keys = user.sshKeys;
  };

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
    # some basic packages you would expect to find on a  new system
    cached-nix-shell
    file
    man-pages
    man-pages-posix
    fx
    gcc
    gnutar
    jq
    ncdu
    netcat-openbsd
    nix-shell-override
    pass
    python3
    tcpdump
    tree
    unzip
    wget
    zip
  ];

  documentation.enable = true;
  documentation.man.enable = true;

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

  # convenient little oneliner to print system changes on rebuilds
  system.activationScripts.diff = ''
    if [[ -e /run/current-system ]]; then
      ${pkgs.nix}/bin/nix --extra-experimental-features nix-command store diff-closures /run/current-system "$systemConfig"
    fi
  '';
}
