#!/bin/bash
# Script to list available Wi-Fi networks and connect to one using rofi and nmcli

# Get a list of available networks
networks=$(nmcli -t -f SSID,SECURITY dev wifi list | awk -F: '{print $1 " (" $2 ")"}')

# Use rofi to select a network
selected_network=$(echo "$networks" | rofi -dmenu -p "Select Wi-Fi network:")

# Extract SSID and SECURITY from the selected network
ssid=$(echo "$selected_network" | awk -F" (" '{print $1}')
security=$(echo "$selected_network" | awk -F"(" '{print $2}' | awk -F")" '{print $1}')

# Check if the network is secured
if [[ "$security" == "--" ]]; then
    # Connect to the open network
    nmcli dev wifi connect "$ssid"
else
    # Prompt for password
    password=$(rofi -dmenu -p "Enter password for $ssid:")

    # Connect to the secured network
    if [ -n "$ssid" ] && [ -n "$password" ]; then
        nmcli dev wifi connect "$ssid" password "$password"
    else
        echo "SSID or password is empty"
    fi
fi
