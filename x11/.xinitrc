# sourced on 'startx'

# source xresources
# xrdb ${XDG_CONFIG_HOME:-$HOME/}/.xresources &
xrdb ${XDG_CONFIG_HOME:-$HOME/}/.xresources

# set resolution
xrandr -s 1920x1080

# set background
~/.fehbg  

# start compositor
xcompmgr &

# start dwm-blocks (status-bar)
dwmblocks &

# controls repeat-delay for keys, first argument is time
# to wait before repeating, second controls the rate
xset r rate 200 30

# hides cursor when inactive
unclutter &         

# start window manager
exec dwm
