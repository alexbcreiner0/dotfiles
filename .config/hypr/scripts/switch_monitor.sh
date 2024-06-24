#!/bin/bash

WININFO="$(hyprctl activewindow | grep monitor | awk '{print $2}')"

echo "$WININFO"

if [[ $WININFO == 1 ]]; then
    echo "Primary monitor"
    WORKSPACE=$(hyprctl monitors | grep -A 6 "(ID 0)" | grep "active workspace" | awk '{print $3}')
    echo "$WORKSPACE"
else
    echo "Secondary monitor"
    WORKSPACE=$(hyprctl monitors | grep -A 6 "(ID 1)" | grep "active workspace" | awk '{print $3}')
    echo "$WORKSPACE"
fi

echo "Captured workspace: '$WORKSPACE'"
hyprctl dispatch movetoworkspace $WORKSPACE

