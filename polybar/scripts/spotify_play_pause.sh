#!/bin/bash
status=$(playerctl -p 'spotify' status)
if [[ "$status" == "Playing" ]];then
	echo "󰏤1"
elif [[ "$status" ==  "Paused" ]];then
	echo ""
else
	echo "asfdf"
fi
