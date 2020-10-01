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
    BRANCH=$(git symbolic-ref --short HEAD 2> /dev/null)
    if [ -z "$BRANCH" ]; then
        PS1+=""
    else
        CHANGES=$(git status --short | wc -l | awk '{$1=$1};1')
        if [ $CHANGES -eq 0 ]; then
            PS1+=", ($BRANCH)"
        else
            PS1+=", ($BRANCH+$CHANGES)"
        fi
    
    fi
    PS1+="%f"
    PS1+="%B%F{214}]%f%b%B%F{167} ❯❯%f%b "
}

precmd_functions+=(update_prompt)

# =======================================================================

update_prompt
chpwd() ls;  # auto-ls
