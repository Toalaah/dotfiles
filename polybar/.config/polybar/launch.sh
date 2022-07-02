#!/bin/bash

killall -q polybar

# launch polybar
# polybar -c "$HOME"/.config/polybar/config.ini main 2>&1 | tee -a /tmp/polybar.log & disown

# In order to achieve the desired stylistic goal, the status bar actually
# consists of multiple sub-bars which inherit from a base bar. These bars are
# layed out as follows:

#                  ⌄ Top of monitor ⌄
# | wm-layout  date   workspaces   sys-stats  power|
#

# launch all bars
polybar -c "$HOME"/.config/polybar/config.ini layout     2>&1 | tee -a /tmp/polybar.log & disown
polybar -c "$HOME"/.config/polybar/config.ini date       2>&1 | tee -a /tmp/polybar.log & disown
polybar -c "$HOME"/.config/polybar/config.ini workspaces 2>&1 | tee -a /tmp/polybar.log & disown
polybar -c "$HOME"/.config/polybar/config.ini system     2>&1 | tee -a /tmp/polybar.log & disown
polybar -c "$HOME"/.config/polybar/config.ini power      2>&1 | tee -a /tmp/polybar.log & disown
