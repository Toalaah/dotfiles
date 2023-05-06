user := `whoami`
host := `nix run nixpkgs#hostname`

# print this help menu
help:
  just --list

# common handler for build and switch recipes
_handler ACTION TYPE="system" TARGET="":
  #! /usr/bin/env nix-shell
  #! nix-shell -i bash -p home-manager nixos-rebuild
  set -xe
  _target_impl={{TARGET}}
  case "{{TYPE}}" in
    "system")
      target=${_target_impl:-{{host}}}
      rebuild_cmd="nixos-rebuild"
      if [ {{ACTION}} == "switch" ]; then rebuild_cmd="sudo nixos-rebuild"; fi
      ${rebuild_cmd} --flake ".#${target}" {{ACTION}}
      exit $?
    ;;
    "home")
      target=${_target_impl:-{{user}}}
      home-manager --flake ".#${target}" {{ACTION}}
      exit $?
    ;;
    *)
      echo "Unknown type '{{TYPE}}'"
      exit 1
    ;;
  esac
  # how did we end up here?
  exit 1

# rebuild a nixos or home configuration
build TYPE="system" TARGET="": (_handler "build" TYPE TARGET)

# rebuild and switch to a nixos or home configuration
switch TYPE="system" TARGET="": (_handler "switch" TYPE TARGET)

# update all flake dependencies
update:
  nix flake update

alias fmt := format
# run formatter
format:
  nix fmt

# check flake configuration
check:
  nix flake check

# clean nix store
clean:
  nix-store --gc
  nix-store --optimise
