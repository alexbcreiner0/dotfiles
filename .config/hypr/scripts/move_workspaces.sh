#!/bin/bash
direc=$1
current=$(hyprctl activeworkspace | grep workspace | awk '{print $3}')
if [[ $direc == '--left' ]]; then
    new=$((current-1))
else
    new=$((current+1))
fi

# Laptop
if [[ $new -ge 1 && $new -le 5 ]]; then 
    hyprctl dispatch movetoworkspace $new
fi
