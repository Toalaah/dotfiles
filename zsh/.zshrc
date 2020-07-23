export ZSHRC=$HOME/config/zsh/.zshrc
export VIMRC=$HOME/config/vim/init.vim
export CONFIG=$HOME/config


PROMPT="%B%F{105}[%f%b%F{51}s%f%F{105}@%f%F{51}osx%f:%1d%B%F{105}]%f%b%F{51}%f "

# automatically ls when cd-ing
#autoload -U add-zsh-hook
#add-zsh-hook -Uz chpwd (){ ls -a; }


# some aliases
alias vim=nvim
alias zip="zip -r -X archive.zip"
alias ..="cd .."
alias ...="cd ..;cd .."
alias ll="ls -l"
alias la="ls -l -a"

# automatically compiles latex documents on vim-write
# this is quite useful for pseudo-realtime updates when using
# a pdf viewer such as skim
function pdf() {
pdflatex --interaction=batchmode "$1" && latexmk -c "$1"
}

source $HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
