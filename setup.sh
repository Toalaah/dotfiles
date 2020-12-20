echo "* Beginning setup...\n"

echo "* Searching for pre-existing config files...\n"
FILE=~/.zshrc
if test -f "$FILE"; then
	echo "* Found zshrc at , $FILE, backing up to $FILE.bak."
	cp ~/.zshrc ~/.zshrc.bak
fi

FILE=~/.tmux.conf
if test -f "$FILE"; then
	echo "* Found tmux config at , $FILE, backing up to $FILE.bak."
	cp ~/.tmux.conf ~/.tmux.conf.bak
fi

FILE=~/.config/nvim/init.vim
if test -f "$FILE"; then
	echo "* Found nvim config at , $FILE, backing up to $FILE.bak."
	cp ~/.config/nvim/init.vim ~/.config/nvim/init.vim.bak 
fi

echo "* Backups completed\n"

echo "* Creating new source files...\n"
# create new dotfiles through reference
echo source ~/config/zsh/zshrc > ~/.zshrc
echo source ~/config/vim/init.vim > ~/.config/nvim/init.vim 
echo source ~/config/tmux/tmux.conf > ~/.tmux.conf



echo "* adding git shortcuts...\n"
# add various git shortcuts
git config --global alias.s status
git config --global alias.br branch
git config --global alias.co checkout
git config --global alias.cm commit



echo "* done\n"

# brew requirements:
# llvm, zsh-syntax-highlghting, nvim, git, tmux, iterm2

# nvim requirements / other installs
# ctrlp-search (http://ctrlpvim.github.io/ctrlp.vim/#installation)
# coc https://www.chrisatmachine.com/Neovim/04-vim-coc/

#other todos
# faster dock hiding / appearing
# disable mouse-acceleration (for when not using trackpad)
