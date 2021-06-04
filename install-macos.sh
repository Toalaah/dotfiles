#!/bin/sh


# TODO: nvim appimage needs to be changed to mac-os specific
# TODO: nvim folder needs to be moved to usr/local/bin and added
#       to path
# TODO: latex-lsp needs to be changed to mac-os specific
# TODO: clangd needs to be changed to llvm


CYAN=$(tput setaf 6)
NORM=$(tput sgr0)

status()
{
  [ $# -eq 0 ] || echo "${CYAN}=>${NORM}" $1
} 

install()
{
  [ $# -eq 0 ] || brew install $1
}

# --------------------------------------------
# Neovim Installation and Plugin Configuration 
# --------------------------------------------

status "Getting latest neovim nightly build..."         # Download nvim appimage
curl --version >/dev/null 2>&1 || 
  (status "Installing curl..." && install "curl")       # Check if curl installed
curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod u+x ./nvim.appimage && sudo mv ./nvim.appimage /usr/local/bin/nvim
status "Done"

status "Installing vim-plug..."                         # Install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
status "Done"

status "Copying config files to $HOME/.config/nvim ..." # Copy  config files
mkdir -p $HOME/.config                                  # Make directories (if necessary)
cp -r ./nvim $HOME/.config/
status "Done"

status "Installing language server dependencies..."     # Install node / npm
status "Installing node.js / npm..."
install "npm" 
sudo npm install -g npm
sudo npm cache clean -f
sudo npm install -g n
sudo n stable
status "Done"

status "Installing cargo..."                            # Install cargo 
                                                        # [ This is needed to install texlab LSP ]
curl https://sh.rustup.rs -sSf | sh
status "Done"

status "Installing texlab..."                           # Install Latex-LSP
curl -LO https://github.com/latex-lsp/texlab/releases/download/v3.0.0/texlab-x86_64-linux.tar.gz
tar -xf texlab-x86_64-linux.tar.gz
mkdir -p $HOME/.cargo/bin 
sudo mv texlab $HOME/.cargo/bin/
rm texlab-x86_64-linux.tar.gz
status "Done"

status "Installing clangd language server"              # Install clang LSP
install "clangd"
status "Done"

status "Installing pyright..."                          # Install python LSP
sudo npm install -g pyright
status "Done"
status "Installing vimls..."                            # Install vim-LSP
sudo npm install -g vim-language-server
status "Done"

status "Installing typescript language server..."       # Install typescript LSP
sudo npm install -g typescript typescript-language-server
status "Done"

status "Installing bash language server..."             # Install bash LSP
sudo npm install -g bash-language-server
status "Done"

# ----------------
# zsh installation 
# ----------------

zsh --version >/dev/null 2>&1 || 
  (status "Installing zsh..." && install "zsh")       # Check if zsh installed
cp zsh/.zshrc $HOME/.zshrc

status "Installing syntax-highlighting..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting && cd zsh-syntax-highlighting
sudo make install && cd ../ && rm -rf zsh-syntax-highlighting
status "Done"

status "Installing auto-completion..."
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
status "Done"

# -----------------
# tmux installation 
# -----------------

tmux --version >/dev/null 2>&1 || 
  (status "Installing tmux..." && install "tmux")       # Check if tmux installed
cp tmux/.tmux.conf $HOME/.tmux.conf
status "Done"

