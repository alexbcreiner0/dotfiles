#!/bin/bash

DESKTOP_DIRS="/usr/share/applications /home/$USER/.local/share/applications /var/lib/flatpak/exports/share/applications"

DESKTOP_FILE=$(find $DESKTOP_DIRS -name "*.desktop" | rofi -dmenu -p "Select .desktop file to edit:")

if [ -n "$DESKTOP_FILE" ]; then
    xdg-open "$DESKTOP_FILE"
fi
