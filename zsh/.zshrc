#PROMPT="%F{49}%n%f%F{134}@osx%f:%F{144}%1d%f%F{49}$ %f"
export TERM=xterm-256color
#PROMPT="%B%F{105}[%f%b%F{51}s%f%F{105}@%f%F{51}osx%f:%1d%B%F{105}]%f%b%F{51}→%f "
PROMPT="%B%F{105}[%f%b%F{51}s%f%F{105}@%f%F{51}osx%f:%1d%B%F{105}]%f%b%F{51}%f "
alias vim=nvim

alias zip="zip -r -X archive.zip"


alias ..="cd .."
alias ...="cd ..;cd .."

alias ll="ls -l"
alias la="ls -l -a"

function pdf() {
pdflatex --interaction=batchmode "$1" && latexmk -c "$1"
}


# neofetch
