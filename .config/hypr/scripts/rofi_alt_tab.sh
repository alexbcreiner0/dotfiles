#!/bin/bash
# rofi-alt-tab.sh

# Show the Rofi window switcher and capture the selected window ID
window_id=$(rofi -show window -kb-row-down "Alt+Tab" -kb-row-up "Alt+Shift+Tab" -dmenu -i | awk '{print $1}')

# If a window was selected, focus it
if [ -n "$window_id" ]; then
  hyprctl dispatch focuswindow $window_id
fi

