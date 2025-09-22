#!/usr/bin/env bash

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME background.height=40 
    sketchybar --set $NAME background.color=$BAR_COLOR

else
    sketchybar --set $NAME background.height=20 
    sketchybar --set $NAME background.color=$BAR_COLOR
fi
