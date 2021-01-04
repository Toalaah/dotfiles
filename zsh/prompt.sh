autoload -U colors && colors # colors
setopt PROMPT_SUBST
function update_prompt() {
    PS1="%B%F{108}[%f%b%F{66}%2d%f%F{109}"

    # find out if in git repo or not, and if so what branch
    BRANCH=$(git symbolic-ref --short HEAD 2> /dev/null)
    if [ -z "$BRANCH" ]; then
        PS1+=""
    else
        CHANGES=$(git s --short | wc -l | awk '{$1=$1};1')
        if [ $CHANGES -eq 0 ]; then
            PS1+=", ($BRANCH)"
        else
            PS1+=", ($BRANCH+$CHANGES)"
        fi
    
    fi
    PS1+="%f%B%F{108}]%f%b%B%F{250} ::%f%b "
}

