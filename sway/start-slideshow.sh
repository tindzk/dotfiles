#!/bin/sh
pkill waybar

pid_file=/tmp/wallpaper.pid

/home/tim/dotfiles/sway/open-workspace.py

paperlike-cli -i2c /dev/i2c-20 -speed 5 # Black++

# Clear, otherwise "Black++" will be visible on the screen
sleep 0.5
paperlike-cli -i2c /dev/i2c-20 -clear

# Remove remaining artefacts of "Black++"
sleep 0.5
paperlike-cli -i2c /dev/i2c-20 -clear

# Clear must be applied first before setting contrast
sleep 0.5
paperlike-cli -i2c /dev/i2c-20 -contrast 2

sleep 0.5
paperlike-cli -i2c /dev/i2c-20 -mode 3

while true; do
  kill $(cat $pid_file)
  wallpaper=$(find ~/wallpapers/. -type f | shuf -n1)
  echo $wallpaper
  swaybg -i $wallpaper -m fit &
  echo $! > $pid_file
  sleep 3600  # Every hour
done
