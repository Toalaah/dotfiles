export TERM=xterm-256color

PROMPT="%B%F{105}[%f%b%F{51}s%f%F{105}@%f%F{51}osx%f:%1d%B%F{105}]%f%b%F{51}%f "

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


