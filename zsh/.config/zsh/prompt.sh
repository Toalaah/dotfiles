# enable colored prompt prompt
autoload -U colors && colors

COL1="%{$fg[yellow]%}"    # path color
COL2="%{$fg[blue]%}"      # arrow prompt color
RST="%{$reset_color%}"    # reset colors + styles

# attempt to start gitstatus daemon
gitstatus_stop 'MY' 2>/dev/null && gitstatus_start -s -1 -u -1 -c -1 -d -1 'MY' 2>/dev/null || DISABLE_VCS_INFO=1

# set default arrow
ARROW="${ARROW:-}"
[[ "$EUID" -eq 0 ]] && ARROW="#"

function update_prompt() {
  EXIT_CODE="$?"
  RPROMPT=""
  GIT_INFO=""
  (( EXIT_CODE )) && RPROMPT="%B[${COL2}${EXIT_CODE}${RST}%B]${RST}"

  VENV=$([[ -z "$VIRTUAL_ENV" ]] || echo "("$(basename "$VIRTUAL_ENV")")")

  # get VCS (git) info if required plugins are installed
  if [[ -z $DISABLE_VCS_INFO ]] && gitstatus_query MY 2>/dev/null && [[ $VCS_STATUS_RESULT == ok-sync ]]; then
    BRANCH=${${VCS_STATUS_LOCAL_BRANCH}//\%/%%}                                   # get branch name, escape %
    CHANGES=$(( VCS_STATUS_NUM_UNSTAGED+VCS_STATUS_NUM_UNTRACKED ))               # get no. changes

    (( CHANGES )) && GIT_INFO=" on %B${COL1}${BRANCH} (+${CHANGES})${RST}"  || GIT_INFO=" on %B${COL1}${BRANCH}${RST}"
  fi

  PROMPT="%B${COL2}${VENV}${COL1}%2~${RST}${GIT_INFO} ${COL2}${ARROW}${RST} "
}

precmd_functions+=(update_prompt)

