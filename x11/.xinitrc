# file is sourced on 'startx'

# flutter exports / android studio fixes
export _JAVA_AWT_WM_NONREPARENTING=1
export CHROME_EXECUTABLE=$(which chromium)

# set background, resolution,xresources
~/.fehbg
xrandr -s 1920x1080
xrdb -DPYWAL_="<${XDG_CONFIG_HOME:-$HOME/}.cache/wal/colors.Xresources>" -merge ${XDG_CONFIG_HOME:-$HOME/}.xresources

picom --experimental-backends -b # start compositor
dwmblocks &                      # start dwm-blocks (status-bar)
xset -dpms                       # disable screen saving
xset s off                       # disable and change key-repeat delays
xset r rate 200 30               # (repeat delay for keys, 200ms to wait before repeat, 30ms rate when holding down key)
setxkbmap us altgr-intl          # easier typing of umlauts
unclutter -idle 2 &              # hide cursor when inactive for 2 seconds
dunst &                          # notification daemon
exec dwm                         # start window manager

