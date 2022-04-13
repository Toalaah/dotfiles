# Config ⚙️

![Installer Status](https://github.com/toalaah/config/actions/workflows/test.yml/badge.svg)
![Lint Status](https://github.com/toalaah/config/actions/workflows/lint.yml/badge.svg)
![Format Status](https://github.com/toalaah/config/actions/workflows/format.yml/badge.svg)

## Table of Contents

1. [About](#about)
2. [Requirements](#requirements)
3. [Installation](#installation)
    1. [Automatic](#automatic)
    2. [Manual](#manual)
4. [Uninstalling](#uninstallation)
5. [Notes](#todos)

## About

This repository contains all my personal dotfiles as well as a semi-automated
setup script which can be used to quickly setup my configuration on new
systems. At the moment, this includes configuration files for:

- neovim
- tmux
- alacritty
- zsh
- X.Org (xinitrc, xresources)
- bin (custom scripts)

... and more!

This repo also contains most of my wallpapers which I have collected over time.
However, due to the size of the wallpapers it is only contained as a
sub-module, which you can find [here](https://github.com/toalaah/wallpapers).

## Requirements

If you wish to install using the installer script you will need the following:

- An internet connection to pull dependencies during installation
- The following packages / programs:
  - stow
  - git
  - curl
- Additionally, if you wish to **bootstrap** the nvim configuration, you will
  require (only recommended for / tested on a clean system with no existing
  nvim-config):
  - unzip
  - npm
  - rg
  - fd
  - make

Furthermore, it is recommended you install a font which supports glyphs, for
example one of the nerd-fonts from
[here](https://github.com/ryanoasis/nerd-fonts).

## Installation

### Automatic

**Important**: This script will overwrite all existing configuration files for
the aforementioned programs. **No backups of any kind will be created for
you**. The script will prompt you on whether or not  you wish to continue
before overwriting.

If you specify the `-y` or `--yes` flag, the script will auto-install **all**
config-files **without** asking for confirmation. This flag will also bootstrap
nvim if the required dependencies are installed on the host machine.

To install all configuration files automatically, run the following script (at
your own discretion). You will be asked whether or not you want to also
download the wallpapers.

```bash
# hand-pick the config-files you want to install
bash <(curl -s https://raw.githubusercontent.com/Toalaah/config/master/install.sh)

# install all config-files without asking for confirmation
bash \
<(curl -s https://raw.githubusercontent.com/Toalaah/config/master/install.sh) --yes
```

This will create a folder in `~/.local/dotfiles` in which the configuration
files are stored and later symlinked from.

**Important**: Do not delete the folder after installation as it merely
symlinks the dotfiles using stow, leaving you with dangling symlinks should the
repository be deleted.

### Manual

1. Clone and navigate into the repository.

```bash
git clone https://github.com/toalaah/config ~/.local/dotfiles
cd ~/.local/dotfiles
```

1. **Optional**: If you wish to download the wallpapers as well run the followin
g commands from _inside_ the repository folder.

```bash
git submodule init
git submodule update
```

1. For each dotfile you wish to install run the following command from _inside_
the repository folder.

```bash
stow -t $HOME <CONFIG>
```

Where `<CONFIG>` is the configuration you wish to install (ex: nvim, zsh,
or tmux).

## Uninstalling

To uninstall a specific dotfile, navigate into `~/.local/dotfiles` and run `stow
 -D <CONFIG> -t $HOME`, where `<CONFIG>` is the configuration you wish to remove
 (ex: nvim, zsh, or tmux).

## TODOS

- Uninstaller
- Dunst config
