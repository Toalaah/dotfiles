# Dotfiles

Houses the configuration for all my systems and programs, facilitated primarily
by [**Nix Flakes**](https://nixos.wiki/wiki/Flakes) and [**Home
Manager**](https://github.com/nix-community/home-manager).

## Usage

### Bootstrap

#### New NixOS system

```shell
sudo nixos-rebuild \
  --flake github:Toalaah/dotfiles'#'$(hostname) \
  switch
```
#### Non-NixOS system (eg. dotfiles only)

```shell
nix run nixpkgs'#'home-manager -- \
  --experimental-features 'nix-command flakes' \
  --flake github:Toalaah/dotfiles'#'$(whoami) \
  switch
```

## Todos

- Figure out nice bootstrap process
- ZFS compression on `/nix/store`
- Optimize power / performance
- YubiKey disk encryption
- MPV configuration
