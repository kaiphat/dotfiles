#! /bin/bash

CURRENT_LAYOUT=$(setxkbmap -query | awk '/layout/ {print $2}')

if [ "$CURRENT_LAYOUT" = "us" ]; then
  setxkbmap ru -option ctrl:swapcaps
else
  setxkbmap us -option ctrl:swapcaps
fi
