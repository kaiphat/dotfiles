#!/bin/bash
ps_out=`ps -ef | grep "spotify" | grep -v 'grep' | grep -v $0`
result=$(echo $ps_out | grep "spotify")
if [[ "$result" != "" ]];then
    song=`python3 ~/.config/polybar/scripts/spotify_status.py -f '{artist}: {song}'`
    echo ${song}
else
    echo ""
fi
