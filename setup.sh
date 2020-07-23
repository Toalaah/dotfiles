echo "* beginning setup...\n"
echo "* searching for pre-existing config files...\n"

# check for existing files in home dir, make backup
echo "* creating backups...\n"
mv $HOME/.zshrc $HOME/.zshrc.bak &> ./log
mv $HOME/.vimrc $HOME/.vimrc.bak &> ./log
mv $HOME/.tmux.conf $HOME/.tmux.conf.bak &> ./log
rm ./log

echo "* creating new source files...\n"

# create new dotfiles through reference
echo "source $HOME/config/zsh/.zshrc" >$HOME/.zshrc
echo "source $HOME/config/vim/.vimrc" >$HOME/.vimrc
echo "source $HOME/config/tmux/.tmux.conf" >$HOME/.tmux.conf
mkdir -p $HOME/.config/nvim
echo "set runtimepath^=~/.vim runtimepath+=~/.vim/after\nlet &packpath = &runtimepath\nsource ~/.vimrc" >$HOME/.config/nvim/init.vim

echo "* done"
