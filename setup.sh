echo "* beginning setup...\n"
echo "* searching for pre-existing config files...\n"

# check for existing files in home dir, make backup
echo "* creating backups...\n"
mv ~/.zshrc ~/.zshrc.bak &> ./log
mv ~/.vimrc ~/.vimrc.bak &> ./log
mv ~/.tmux.conf ~/.tmux.conf.bak &> ./log
rm ./log

echo "* creating new source files...\n"

# create new dotfiles through reference
echo "source ~/config/zsh/zshrc.sh" >~/.zshrc
echo "source ~/config/vim/init.vim" >~/.vimrc
echo "source ~/config/tmux/tmux.conf" >~/.tmux.conf
#mkdir -p ~/.config/nvim
#echo "set runtimepath^=~/.vim runtimepath+=~/.vim/after\nlet &packpath = &runtimepath\nsource ~/init.vim" >$HOME/.config/nvim/init.vim

echo "* done"
