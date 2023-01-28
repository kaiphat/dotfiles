#! /bin/bash

# picom -b
nitrogen --set-scaled ~/Pictures/Wallpapers/tim-marshall-nuc-mltC4iQ-unsplash\(1\).jpg &
setxkbmap us -option ctrl:swapcaps &
xsetroot -cursor_name left_ptr &
xset r rate 220 50 & # type speed
xss-lock --transfer-sleep-lock --i3lock --nofork &
killall -q dunst &
dunst &

# mouse speed
INDEX=$(xinput --list | awk '/Razer Razer DeathAdder Essential\s+id.*slave.*pointer/' | awk -F "[^0-9]*" '{print $2}')
PROP_INDEX=$(xinput --list-props $INDEX | awk '/Coordinate Transformation Matrix/' | awk -F "[^0-9]*" '{print $2}')
xinput --set-prop $INDEX $PROP_INDEX 0.3 0 0 0 0.3 0 0 0 1

