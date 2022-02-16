# sourced on 'startx'

# source xresources
# xrdb ${XDG_CONFIG_HOME:-$HOME/}.xresources
xrdb -DPYWAL_="<${XDG_CONFIG_HOME:-$HOME/}.cache/wal/colors.Xresources>" -merge ${XDG_CONFIG_HOME:-$HOME/}.xresources

# set resolution
xrandr -s 1920x1080

# set background
~/.fehbg
# wal -R

# start compositor
xcompmgr &

# start dwm-blocks (status-bar)
dwmblocks &

# android studio fix
export _JAVA_AWT_WM_NONREPARENTING=1
# set flutter chrome executable to chromium
export CHROME_EXECUTABLE=$(which chromium)

# disable screen saving and change key-repeat delays
xset -dpms
xset s off
# controls repeat-delay for keys, first argument is time
# to wait before repeating, second controls the rate
xset r rate 200 30

# allow to type german umlauts with (right-alt + Shift + ') followed by a, u, o
setxkbmap us altgr-intl

# hides cursor when inactive
unclutter &

# notifications
dunst &

# set editor
export EDITOR=nvim

# start window manager
exec dwm

