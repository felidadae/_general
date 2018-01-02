#!/bin/bash -ex

id_active="$(xdotool getactivewindow)"
xdotool windowminimize "$id_active"
sleep 0.1
xdotool windowsize "$id_active" ${1}% 100%

IFS='x' read screenWidth screenHeight < <(xdpyinfo | grep dimensions | grep -o '[0-9x]*' | head -n1)

width=$(xdotool getwindowgeometry "$id_active"  | head -4 | tail -1 | sed 's/[^0-9]*//' | perl -F'x' -lane 'print "$F[0]"')
width=$((width+100))
height=$(xdotool getwindowgeometry "$id_active"  | head -4 | tail -1 | sed 's/[^0-9]*//' | perl -F'x' -lane 'print "$F[1]"')

newPosX=$((screenWidth/2-width/2))
newPosY=$((screenHeight/2-height/2))

xdotool windowmove "$id_active" "$newPosX" "0"
wmctrl -s 4
# sleep 1
# wmctrl -ia "$id_active"
sleep 0.3
xdotool windowactivate "$id_active"
sleep 0.5
wmctrl -s 1
