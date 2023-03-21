#! /bin/bash

CURRENT_LAYOUT=$(setxkbmap -query | awk '/layout/ {print $2}')

if [ "$CURRENT_LAYOUT" = "us" ]; then
  setxkbmap ru
else
  setxkbmap us
fi
