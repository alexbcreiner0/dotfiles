#!/bin/sh

arg=$1
if [[ $arg == "office" ]]; then
    rm $HOME/.config/hypr/workspaces.conf
    cp $HOME/.config/hypr/workspaces_office.conf $HOME/.config/hypr/workspaces.conf
    exit 0
elif [[ $arg == "standalone" ]]; then
    rm $HOME/.config/hypr/workspaces.conf
    cp $HOME/.config/hypr/workspaces_standalone.conf $HOME/.config/hypr/workspaces.conf
    exit 0
else
    echo "Error swapping workspaces. Argument $1 not recognized."
    exit 1
fi
