#!/usr/bin/env bash
source "$HOME/.config/sketchybar/colors.sh"
sketchybar --remove '/space\..*/'

FOCUSED="$(aerospace list-workspaces --focused 2>/dev/null | head -n1)"
WORKSPACES_WITH_WINDOWS=$(aerospace list-windows --all --format %{workspace})

ALL_WORKSPACES=$(echo -e "$WORKSPACES_WITH_WINDOWS\n$FOCUSED" | sort -n | uniq | grep -v '^$')

for sid in $ALL_WORKSPACES; do
    if [ "$sid" = "$FOCUSED" ]; then
        BG_HEIGHT=40
        BG_COLOR=$GREY
    else
        BG_HEIGHT=20
        BG_COLOR=$BLACK
    fi
    
    sketchybar --add item "space.$sid" left \
        --subscribe "space.$sid" aerospace_workspace_change \
        --set "space.$sid" \
            icon="$sid" \
            icon.padding_left=22 \
            icon.padding_right=22 \
            label.padding_right=33 \
            background.color=$BG_COLOR \
            background.corner_radius=10 \
            background.height=$BG_HEIGHT \
            background.drawing=on \
            height=60 \
            label.font="sketchybar-app-font:Regular:16.0" \
            label.background.height=30 \
            label.background.drawing=on \
            label.background.color=$GREY \
            label.background.corner_radius=9 \
            label.drawing=off \
            click_script="aerospace workspace $sid" \
            script="$CONFIG_DIR/plugins/aerospace.sh $sid"
done



