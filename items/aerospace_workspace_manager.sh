#!/usr/bin/env bash
sketchybar --add event aerospace_workspace_change
sketchybar --add item workspace_manager left \
    --set workspace_manager \
    --subscribe workspace_manager aerospace_workspace_change \
        drawing=off \
        script="$CONFIG_DIR/plugins/rebuild_bar.sh" \
        updates=on
sketchybar --subscribe workspace_manager aerospace_workspace_change


