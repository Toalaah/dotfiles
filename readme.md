## Config ⚙️

### About

A fully automated setup script which I use to quickly setup new systems. This includes customized installations of neovim, dwm, tmux, and zsh. 

### Prerequisites

- An internet connection to pull dependencies during installation
- One of the following operating systems / Linux distributions: 
  - **macOS** 
  - **Arch Linux**
  - **Ubuntu Linux**

### Installation

1. Clone and navigate into the repository:

```shell
git clone https://github.com/toalaah/config
cd config
```

2. Run the appropriate setup script according to your operating system / distribution. These include `setup-macos`, `setup-arch-linux`, and `setup-ubuntu-linux`.
3. ?

4. Profit 👍

### Notes 

- There are a number of customizable options available with this script. It is recommended to check out the help menu by invoking the `--help` flag before proceeding with the installation.
- The optional `--apps` flag installs a number of apps which I generally would install on a new installation of macOS or Linux distro. These include:
  - **ungoogled-chromium**: basically chrome without many google services. This can also be found over at [eloston/ungoogled-chromium](https://github.com/Eloston/ungoogled-chromium)
  - **skim**: a (in my opinion) better pdf reader than preview as it allows for live updating of files, which is especially useful for latex workflows (this is only relevant to macOS installs)
  - **the unarchiver**: a, well, unarchiver (this is only relevant to macOS installs)
  - **vlc**: for playing back media
  - **discord**: chatting
  - **spotify**: for music
- The optional `--pass` flag is tied to a very specific setup which I followed from [here](https://soemarko.com/blog/complete-guide-for-passwordstore-on-macos). But as long as you use pass with a remote repository and have access to your public and private gpg keys at the time of installation, you should be ok.
