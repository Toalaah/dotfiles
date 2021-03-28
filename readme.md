## Config ⚙️

### Dependencies

Make sure homebrew is installed and preferably updated before starting. You can grab brew with:
```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
Git should also be installed out of the box on a fresh macOS installation but incase you don't have it you can install it using

```shell
brew install git
```


### Installation

1. Clone into the repository and run the setup script:

```shell
git clone https://github.com/toalaah/config
cd setup
./setup --all
```
2. ?

3. Profit 👍

### Notes 

- There are a number of customizable options available to you. I recommend checking the help menu of the script with `./setup --help` before proceeding with the installation.
- For new installations I recommend running `./setup --all` to get the full package of utilities and funcitonality, however all features are also individually choosable to your liking.
- This has only been tested on fresh macOS installations and as such I can only recommend you do the same (it is a 'setup' script, afterall). However, you should still be able to install dotfiles only with `./setup --min` without too many issues, even on an existing installation **(this will even work on non-macOS machines!)**.
- The `-apps` option installs a number of apps which I generally would install on a new installation of macOS. These include:
  - **ungoogled-chromium**: basically chrome without many google services. This can also be found over at [eloston/ungoogled-chromium](https://github.com/Eloston/ungoogled-chromium)
  - **skim**: a (in my opinion) better pdf reader than preview as it allows for live updating of files, which is especially useful for latex workflows
  - **the unarchiver**: a, well, unarchiver
  - **vs-code**: incase I can't or dont want to work in vim for whatever reason
  - **vlc**: for playing back media 
  - **discord**: chatting
  - **spotify**: for music
- The `-pass` option is tied to a very specific setup which I followed from [here](https://soemarko.com/blog/complete-guide-for-passwordstore-on-macos). But as long as you use pass with a remote repository and have access to your public and private gpg keys at the time of installation, you should be ok.
