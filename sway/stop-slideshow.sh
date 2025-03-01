#!/bin/sh
pid_file=/tmp/wallpaper.pid

pkill start-slideshow

kill $(cat $pid_file)
rm $pid_file

swaybg -c FFFFFF &
echo $! > $pid_file

waybar &

swaymsg '[con_mark=_prev] focus'

paperlike-cli -i2c /dev/i2c-20 -speed 1

sleep 0.5 # Otherwise the following command may be ignored
paperlike-cli -i2c /dev/i2c-20 -clear

sleep 0.5
paperlike-cli -i2c /dev/i2c-20 -contrast 6

sleep 0.5
paperlike-cli -i2c /dev/i2c-20 -mode 3
