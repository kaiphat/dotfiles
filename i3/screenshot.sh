#! /bin/fish

scrot -s -q 100 -f -e 'xclip -selection clipboard -t image/png -i $f'
