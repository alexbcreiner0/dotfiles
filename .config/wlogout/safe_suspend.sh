#!/bin/bash

if mountpoint -q "/home/alex/Laptop-Server/"; then
    umount ~/Laptop-Server || exit 1
fi

hyprlock &

sleep 1

systemctl suspend

sleep 1

