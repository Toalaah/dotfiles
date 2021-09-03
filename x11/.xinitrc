xrandr -s 1920x1080 # set resolution
~/.fehbg            # set background
# start compositor
xcompmgr -c -C -t-5 -l-5 -r4.2 -o.55 &
xset r rate 200 30  # controls repeat-delay for keys, first argument is time to wait before repeating, second controls the rate
unclutter &         # hides cursor when inactive
exec dwm            # start window manager
