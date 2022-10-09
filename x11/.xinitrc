# file is sourced on 'startx'

# xdg exports
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}

# flutter exports / android studio fixes
export _JAVA_AWT_WM_NONREPARENTING=1
export CHROME_EXECUTABLE=$(which chromium)

# set background, resolution, xresources
~/.fehbg
xrdb -DPYWAL_="<${XDG_CACHE_HOME:-$HOME/.cache}/wal/colors.Xresources>" -merge "$HOME"/.xresources
if [[ -d "$HOME/.xrdb.d" ]]; then
  for file in "$HOME"/.xrdb.d/*; do
    xrdb -merge "$file"
  done
fi

picom --experimental-backends -b & # start compositor
xset +dpms dpms 600 600 600
lxpolkit &                         # authentication agent
xss-lock lock &
xset r rate 200 30                 # (repeat delay for keys, 200ms to wait before repeat, 30ms rate when holding down key)
setxkbmap us altgr-intl            # easier typing of umlauts
[[ -f "$HOME/.Xmodmap" ]] && xmodmap "$HOME/.Xmodmap"
unclutter -idle 2 &                # hide cursor when inactive for 2 seconds
dunst &                            # notification daemon
exec dwm                           # start window manager
# vim:ft=sh
