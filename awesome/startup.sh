#! /bin/bash

killall pulseaudio &
picom -b &
nitrogen --set-scaled ~/Pictures/Wallpapers/wallhaven-4opomm_3840x2160.png &
mpris-proxy & 
setxkbmap -option ctrl:swapcaps &
xsetroot -cursor_name left_ptr & 
pulseaudio &
xset r rate 220 50 & # type speed
xinput --set-prop 14 179 0.3 0 0 0 0.3 0 0 0 1 # mouse speed
