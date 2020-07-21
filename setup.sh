echo "* beginning setup...\n"
echo "* searching for pre-existing config files...\n"

# check for existing files in home dir, make backup
echo "* creating backups...\n"
mv $HOME/.zshrc_ $HOME/.zshrc.bak &> ./log
mv $HOME/.vimrc_ $HOME/.vimrc.bak &> ./log
mv $HOME/.tmux.conf_ $HOME/.tmux.conf.bak &> ./log
rm ./log

echo "* creating new source files...\n"

# create new dotfiles through reference
echo "source $HOME/config/zsh/.zshrc" >$HOME/test_zsh.txt
echo "source $HOME/config/vim/.vimrc" >$HOME/test_vim.txt
echo "source $HOME/config/tmux/.tmux.conf" >$HOME/test_tmux.txt

echo "* done"
