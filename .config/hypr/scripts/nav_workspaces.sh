#!/bin/bash
# Navigates to new workspace
direc=$1
current=$(hyprctl activeworkspace | grep workspace | awk '{print $3}') # find current workspace
if [[ $direc == '--left' ]]; then
    new=$((current-1))
else
    new=$((current+1))
fi

MONITOR="$(hyprctl activeworkspace | grep monitorID | awk '{print $2}')"
if [[ $MONITOR == '1' && $new -ge 11 ]] || [[ $MONITOR == '0' && $new -ge 1 && $new -le 10 ]]; then 
    hyprctl dispatch workspace $new
fi
