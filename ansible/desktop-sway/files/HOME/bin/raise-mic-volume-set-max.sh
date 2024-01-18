#!/bin/bash

# This script is modified from https://askubuntu.com/questions/1362023/set-max-limit-for-volume-increase-with-i3-pactl-and-bash

# max_volume_pc is set in sway config file: 
# It is last number of corresponding "bindsym" keybinding line

#max_volume_pc=$1
max_volume_pc=100
current_volume_pc=$(pactl get-source-volume @DEFAULT_SOURCE@ | grep 'Volume:' | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')
if (($current_volume_pc < $max_volume_pc-4)) ; then
    pactl set-source-volume @DEFAULT_SOURCE@ +5%
fi
