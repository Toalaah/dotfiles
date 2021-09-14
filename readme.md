## Config ⚙️

### About

A fully automated setup script which I use to quickly setup my dotfiles on new systems. At the moment, this includes configuration files for

- neovim
- tmux
- alacritty
- zsh
- xinitrc
- xresources

This repo also contains most of my wallpapers which I have collected over time. Due to the size of the wallpapers, it is only contained as a submodule, which you can find [here](https://github.com/toalaah/wallpapers).

### Prerequisites

- An internet connection to pull dependencies during installation
- One of the following operating systems / Linux distributions: 
  - **macOS** 
  - **Arch Linux**
  - **Ubuntu Linux**
- The following packages / programs:
  - **stow**
  - **git**
  - **curl**

### Installation (automatic)

To install all dotfiles automatically, run the following script (at your own discretion). You will be prompted whether you want to also download the wallpapers or not. 

```shell
bash <(curl -s https://raw.githubusercontent.com/Toalaah/config/master/install.sh)
```
This will create a folder in `~/.local/dotfiles`. **IMPORTANT**: Do not delete the folder after installing as it merely symlinks the dotfiles using stow.

### Installation (manual)

1. Clone and navigate into the repository

```shell
git clone https://github.com/toalaah/config ~/.local/dotfiles
cd ~/.local/dotfiles
```

2. **(Optional)** If you wish to download the wallpapers as well run the following commands from **inside** the `dotfiles` folder

```shell
git submodule init
git submodule update
```

3. For each dotfile you wish to install run the following command from **inside** the `dotfiles` folder

```shell
stow {CONFIG}
```

Where `{CONFIG}` is the configuration you wish to install (ex: nvim, zsh, or tmux)

### Uninstalling

To uninstall all dotfiles (i.e remove the created symlinks), run the following script:

```shell
bash ~/.local/dotfiles/clean.sh
```
To uninstall a specific dotfile, navigate into `~/.local/dotfiles` and run `stow -D {CONFIG}`, where `{CONFIG}` is the configuration you wish to remove (ex: nvim, zsh, or tmux)
