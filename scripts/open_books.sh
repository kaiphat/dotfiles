#! /bin/sh

cd ~/books

chosen=$(fd ".*\.pdf" | rofi -dmenu -i "Test" )

[[ -z $chosen ]] && exit

zathura $chosen

exit 0

