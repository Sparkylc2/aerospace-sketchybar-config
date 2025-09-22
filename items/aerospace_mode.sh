#!/usr/bin/env sh

sketchybar --add event aerospace_mode
sketchybar --add item aerospace_mode left\
           --set aerospace_mode script="$PLUGIN_DIR/aerospace_mode.sh" \
                               icon.padding_left=10\
                               icon.padding_right=$PADDINGS \
                               label.padding_left=$PADDINGS \
                               label.padding_right=10\
                               background.corner_radius=20\
                               background.height=24 \
           --subscribe aerospace_mode aerospace_mode

sketchybar --trigger aerospace_mode MODE=M
