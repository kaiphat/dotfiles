#!/bin/bash

xset r rate 220 50 & # type speed
xset m 4/1 0 & # mouse speed
setxkbmap -option ctrl:swapcaps & # disable casp lock
xcompmgr -c -C -t-5 -l-5 -r4.2 -o.55 & # transparent background
