# setup completion menu + preferences
autoload -U compinit && compinit
zstyle ":completion:*" menu select
# case-insensitive matching
zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"

set -o NO_BEEP              # no thanks...
set -o GLOB_DOTS            # complete dot-("hidden")files
set -o INTERACTIVE_COMMENTS # allow comments in interactive commands
set -o MENU_COMPLETE        # enable completion menu
set -o INC_APPEND_HISTORY   # incrementally add to history instead of on exit
set -o HIST_IGNORE_SPACE    # don't write commands w/ a leading space to history
set -o HIST_IGNORE_DUPS     # ignore duplicate commands
set -o PUSHDSILENT          # don't print dirname when pushing to direcotry stack without
set -o CD_SILENT            # don't print current dirname after a cd
set -o AUTOCD               # cd to directory when command is name of a directory

chpwd() ls;                 # auto ls on directory changed
