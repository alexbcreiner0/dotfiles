#!/bin/bash

WININFO="$(hyprctl activewindow | grep monitor | awk '{print $2}')"

if [[ $WININFO == 1 ]]; then
    WORKSPACE=$(hyprctl monitors | grep -A 6 "(ID 0)" | grep "active workspace" | awk '{print $3}')
else
    WORKSPACE=$(hyprctl monitors | grep -A 6 "(ID 1)" | grep "active workspace" | awk '{print $3}')
fi

hyprctl dispatch movetoworkspace $WORKSPACE

