#!/bin/sh
$HOME/dotfiles/keyboard.sh
xrandr --dpi 192 &

$HOME/.config/polybar/launch.sh
nitrogen --set-scaled --random $HOME/Wallpapers/ &
albert &
redshift &

# lxqt-connman-applet &
/usr/lib/notification-daemon-1.0/notification-daemon &
nm-applet --sm-disable &
