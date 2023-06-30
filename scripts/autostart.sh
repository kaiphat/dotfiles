#! /bin/bash

pgrep -x sxhkd > /dev/null || sxhkd &
picom -b &
xsetroot -cursor_name left_ptr &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
feh --bg-scale ~/pictures/cristian-palmer-XexawgzYOBc-unsplash.jpg &
xset r rate 220 38 & # type speed
killall -q dunst &
dunst &
xautolock -detectsleep -time 15 -locker "systemctl suspend" -notify 600 -notifier "xset dpms force off" &
setxkbmap -option ctrl:swapcaps us, ru &

indexes=($(xinput --list | awk '/Razer Razer DeathAdder Essential[^a-zA-Z]+id.*slave.*pointer/' | awk -F "[^0-9]*" '{print $2}'))
for i in "${indexes[@]}"
do
  xinput --set-prop $i  "libinput Accel Speed" -1 || true
done
