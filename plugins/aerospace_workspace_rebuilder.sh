#!/usr/bin/env bash
source "$HOME/.config/sketchybar/colors.sh"
sketchybar --remove '/space\..*/'

FOCUSED="$(aerospace list-workspaces --focused 2>/dev/null | head -n1)"
WORKSPACES_WITH_WINDOWS=$(aerospace list-windows --all --format %{workspace})

ALL_WORKSPACES=$(echo -e "$WORKSPACES_WITH_WINDOWS\n$FOCUSED" | sort -n | uniq | grep -v '^$')

for sid in $ALL_WORKSPACES; do
    if [ "$sid" = "$FOCUSED" ]; then
        BG_HEIGHT=40
        BG_COLOR=$BLACK
        FONT="SF Pro Text:Regular:19.0" 
    else
        BG_HEIGHT=20
        BG_COLOR=$BLACK
        FONT="SF Pro Text:Regular:13.0" 
    fi
    
    sketchybar --add item "space.$sid" left \
        --subscribe "space.$sid" aerospace_workspace_change \
        --set "space.$sid" \
            icon="$sid" \
            icon.padding_left=22 \
            icon.padding_right=22 \
            icon.font="$FONT"    \
            label.padding_right=33 \
            background.color=$BG_COLOR \
            background.corner_radius=17 \
            background.height=$BG_HEIGHT \
            background.drawing=on \
            height=60 \
            label.font=$FONT \
            label.background.height=30 \
            label.background.drawing=on \
            label.background.color=$BG_COLOR\
            label.background.corner_radius=20 \
            label.drawing=off \
            click_script="aerospace workspace $sid" \
            script="$CONFIG_DIR/plugins/aerospace.sh $sid"
done



