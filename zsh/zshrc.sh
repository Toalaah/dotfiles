# =============================== ALIASES ===============================

alias vim=nvim
alias zip="zip -r -X archive.zip"
alias ..="cd .."
alias ...="cd ../../"
alias server="php -S localhost:8000"

# =======================================================================
# =============================== PROMPT ================================

autoload -U colors && colors # colors
setopt PROMPT_SUBST
function update_prompt() {
    PS1="%B%F{214}[%f%b%F{108}%2d%f"
    PS1+="%F{109}"

    # find out if in git repo or not, and if so what branch
    BRANCH=$(git branch 2>~/tmp/null |awk '{print $2}')
    if [ -z "$BRANCH" ]; then
        PS1+=""
    else
        # alternate version which shows changes instead of commits
        CHANGES=$(git s --short | wc -l | awk '{$1=$1};1')
        if [ $CHANGES -eq 0 ]; then
            PS1+=", ($BRANCH)"
        else
            PS1+=", ($BRANCH+$CHANGES)"
        fi
    
        # get number of commits ahead
        #COMMITS=$(git rev-list --right-only --count origin/master...@ 2>~/tmp/null)
        #if [ ${COMMITS} -eq 0 ]; then
        #    PS1+=", ($BRANCH)"
        #else
        #    PS1+=", ($BRANCH+$COMMITS)"
        #fi
    fi
    PS1+="%f"
    PS1+="%B%F{214}]%f%b%B%F{167} ❯❯%f%b "
}

precmd_functions+=(update_prompt)

# =======================================================================

# automatically compiles latex documents on vim-write
function pdf() {
pdflatex --interaction=batchmode "$1" && latexmk -c "$1"
}
source $HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
update_prompt
chpwd() ls;  # auto-cd
