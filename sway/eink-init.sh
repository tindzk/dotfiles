#!/bin/sh
paperlike-cli -i2c /dev/i2c-20 -contrast 6
paperlike-cli -i2c /dev/i2c-20 -mode 3
paperlike-cli -i2c /dev/i2c-20 -speed 1
paperlike-cli -i2c /dev/i2c-20 -clear
