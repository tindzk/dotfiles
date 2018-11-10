#!/bin/sh
$HOME/dotfiles/keyboard.sh
xrandr --dpi 192 &

$HOME/.config/polybar/launch.sh
nitrogen --set-scaled --random $HOME/Wallpapers/ &
albert &

# See https://github.com/jonls/redshift/issues/636
/usr/lib/geoclue-2.0/demos/agent &
redshift &

# lxqt-connman-applet &
/usr/lib/notification-daemon-1.0/notification-daemon &
nm-applet --sm-disable &
