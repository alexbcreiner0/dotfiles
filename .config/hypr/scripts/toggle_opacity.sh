#!/bin/sh

check=$(grep " active_opacity" ~/.config/hypr/decoration.conf | awk '{print $3}')

if [ $check == "1" ]; then
    sed -i 's/opacity = 1/opacity = 0.95/g' ~/dotfiles/.config/hypr/decoration.conf
    hyprctl reload
    exit 0
elif [ $check == '0.95' ]; then
    sed -i 's/opacity = 0.95/opacity = 1/g' ~/dotfiles/.config/hypr/decoration.conf
    hyprctl reload
    exit 0
else
    echo "Don't recognize opacity $check"
    exit 1
fi
