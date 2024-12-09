#!/bin/bash

path_name=$(echo "$1" | sed 's/\\ / /g') # replaces literal backslashes with regular spaces?
echo "Path name is $1" > ~/.local/share/nemo/actions/log.txt
folder_name=$2
files=$3
cd "$path_name" >> ~/.local/share/nemo/actions/log.txt 2>&1
echo "Currently in directory $(pwd)" >> ~/.local/share/nemo/actions/log.txt

echo "files: $3" >> ~/.local/share/nemo/actions/log.txt
# echo "Folder name: $2" > ~/.local/share/nemo/actions/log.txt
output_zip="$path_name/$2.zip"
zip -r "$output_zip" . >> ~/.local/share/nemo/actions/log.txt 2>&1

echo "Created zip at $path_name/archive.zip" >> ~/.local/share/nemo/actions/log.txt
