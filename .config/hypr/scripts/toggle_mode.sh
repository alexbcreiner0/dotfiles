#!/bin/bash

check=$(grep "layout" ~/.config/hypr/general.conf | awk '{print $3}')

if [ $check == "dwindle" ]; then
    sed -i 's/dwindle/master/' ~/.config/hypr/general.conf
    exit 0
elif [ $check == "master" ]; then
    sed -i 's/master/dwindle/' ~/.config/hypr/general.conf
    exit 0
else
    echo "Don't recognize current setting, $check"
    exit 1
fi

