#!/usr/bin/sh

CYAN=$(tput setaf 6)
NORM=$(tput sgr0)

status()
{
  [ $# -eq 0 ] || echo "${CYAN}=>${NORM}" $1
} 

install()
{
  [ $# -eq 0 ] || sudo apt-get install $1
}

# First we install neovim nightly through an appimage along with all dependencies for language servers

# Download nvim appimage
#status "Getting latest neovim nightly build..."
#curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage ./nvim.appimage
#chmod u+x ./nvim.appimage && sudo mv ./nvim.appimage /usr/bin/nvim
#status "Installed neovim"

# Install vim-plug
status "Installing vim-plug..."
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
status "Installed vim-plug"

# Copy  config files
status "Copying config files to $HOME/.config/nvim ..."
mkdir -p $HOME/.config # Check if directory does not exists, and if so create it
cp -r ./nvim $HOME/.config/
status "Copied config files"

# Install node / sudo npm
status "Installing language server dependencies..."
status "Installing npm..."
install "npm"
status "Installed npm"

# Install cargo [ This is needed to install texlab LSP ]
status "Installing cargo..."
curl https://sh.rustup.rs -sSf | sh
status "Installed cargo"

# Install Latex-LSP
status "Installing texlab..."
cargo install --git https://github.com/latex-lsp/texlab.git --locked
status "Installed texlab"

# Install clang LSP
status "Installing clangd language server"
install "clangd"
status "Installed clangd"

# Install python LSP
status "Installing pyright..."
sudo npm i -g pyright
status "Installed pyright"

# Install vim-LSP
status "Installing vimls..."
sudo npm i -g vim-language-server
status "Installed vimls"

# Install typescript LSP
status "Installing typescript language server..."
sudo npm install -g typescript typescript-language-server
status "Installed typescript language server"

# Install bash LSP
status "Installing bash language server..."
sudo npm i -g bash-language-server
status "Installed bash language server"

status "Neovim install complete"

