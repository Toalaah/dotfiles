#!/bin/bash

killall -q polybar

# launch polybar
polybar -c "$HOME"/.config/polybar/config.ini main 2>&1 | tee -a /tmp/polybar.log & disown
