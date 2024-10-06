#!/bin/sh

arg=$1
if [[ $arg == "office" ]]; then
    rm $HOME/.config/hypr/monitors.conf
    cp $HOME/.config/hypr/monitors_office.conf $HOME/.config/hypr/monitors.conf
    exit 0
elif [[ $arg == "standalone" ]]; then
    rm $HOME/.config/hypr/monitors.conf
    cp $HOME/.config/hypr/monitors_standalone.conf $HOME/.config/hypr/monitors.conf
    exit 0
elif [[ $arg == "classroom" ]]; then
    rm $HOME/.config/hypr/monitors.conf
    cp $HOME/.config/hypr/monitors_classroom.conf $HOME/.config/hypr/monitors.conf
else
    echo "Error swapping monitors. Argument $1 not recognized."
    exit 1
fi
