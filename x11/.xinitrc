xset r rate 200 30  # controls repeat-delay for keys, first argument is time to wait before repeating, second controls the rate
unclutter &         # hides cursor when inactive
xrandr -s 1920x1080 # set resolution
~/.fehbg &          # set background
exec dwm            # start window manager
