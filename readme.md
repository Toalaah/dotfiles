# Config ⚙️

## Table of Contents

1. [About](#about)
2. [Requirements](#requirements)
3. [Installation](#installation)
    1. [Automatic](#automatic)
    2. [Manual](#manual)
4. [Uninstalling](#uninstallation)

## About

This repository contains all my personal dotfiles as well as a semi-automated setup script which can be used to quickly setup my configuration on new systems. At the moment, this includes configuration files for:

- neovim
- tmux
- alacritty
- zsh
- X.Org (xinitrc, xresources)

This repo also contains most of my wallpapers which I have collected over time. However, due to the size of the wallpapers it is only contained as a sub-module, which you can find [here](https://github.com/toalaah/wallpapers).

## Requirements

If you wish to install using the installer script you will need the following:

- An internet connection to pull dependencies during installation
- The following packages / programs:
  - stow
  - git
  - curl

Furthermore, it is recommended you install a font which supports glyphs, for example one of the nerd-fonts from [here](https://github.com/ryanoasis/nerd-fonts).

## Installation

### Automatic 

**Important**: This script will overwrite all existing configuration files for the aforementioned programs. **No backups of any kind will be created for you**. The script will prompt you whether you want to continue before overwriting. 

To install all configuration files automatically, run the following script (at your own discretion). You will be asked whether or not you want to also download the wallpapers.

```shell
bash <(curl -s https://raw.githubusercontent.com/Toalaah/config/master/install.sh)
```
This will create a folder in `~/.local/dotfiles`.

**Important**: Do not delete the folder after installation as it merely symlinks the dotfiles using stow, leaving you with dangling symlinks.

### Manual

1. Clone and navigate into the repository.

```shell
git clone https://github.com/toalaah/config ~/.local/dotfiles
cd ~/.local/dotfiles
```

2. **Optional**: If you wish to download the wallpapers as well run the following commands from _inside_ the repository folder.

```shell
git submodule init
git submodule update
```

3. For each dotfile you wish to install run the following command from _inside_ the repository folder.

```shell
stow -t $HOME {CONFIG}
```

Where `{CONFIG}` is the configuration you wish to install (ex: nvim, zsh, or tmux).

## Uninstalling

To uninstall all dotfiles (i.e remove the created symlinks), run the following script:

```shell
bash ~/.local/dotfiles/clean.sh
```
To uninstall a specific dotfile, navigate into `~/.local/dotfiles` and run `stow -D {CONFIG}`, where `{CONFIG}` is the configuration you wish to remove (ex: nvim, zsh, or tmux).

