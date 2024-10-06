#!/bin/bash
# Navigates to new workspace and brings current window along
direc=$1
current=$(hyprctl activeworkspace | grep workspace | awk '{print $3}')
if [[ $direc == '--left' ]]; then
    new=$((current-1))
else
    new=$((current+1))
fi

MONITOR="$(hyprctl activeworkspace | grep monitorID | awk '{print $2}')"
if [[ $MONITOR == '1' && $new -ge 11 ]] || [[ $MONITOR == '0' && $new -ge 1 && $new -le 10 ]]; then 
    hyprctl dispatch movetoworkspace $new
fi
