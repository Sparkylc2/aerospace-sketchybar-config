!/usr/bin/env bash


 source "$HOME/.config/sketchybar/colors.sh"

 sketchybar --add event aerospace_workspace_change
 FOCUSED="$(aerospace list-workspaces --focused 2>/dev/null | head -n1)"

 for sid in $(aerospace list-workspaces --all); do
   # if ! aerospace list-windows --workspace "$sid" --format '%{app-name}' 2>/dev/null | grep -q '[^[:space:]]'; then
   #   continue
   # fi
   #
   if [ "$sid" = "$FOCUSED" ]; then
     BG_DRAWING="on"
     BG_HEIGHT=40
     BG_COLOR=0xFF3A3938
   else
     BG_DRAWING="off"
     BG_HEIGHT=20
     BG_COLOR=$BAR_COLOR
   fi

   sketchybar --add item "space.$sid" left \
     --subscribe "space.$sid" aerospace_workspace_change \
     --set "space.$sid" \
       icon="$sid" \
       icon.padding_left=22 \
       icon.padding_right=22 \
       label.padding_right=33 \
       background.color=$BG_COLOR\
       background.corner_radius=10 \
       background.height=$BG_HEIGHT\
       background.drawing=on\
       height=60 \
       label.font="sketchybar-app-font:Regular:16.0" \
       label.background.height=30 \
       label.background.drawing=on \
       label.background.color=$BG_COLOR \
       label.background.corner_radius=9 \
       label.drawing=off \
       click_script="aerospace workspace $sid" \
       script="$CONFIG_DIR/plugins/aerospace.sh $sid"
 done

 sketchybar --add item separator left \
   --set separator icon= \
     background.padding_left=15 \
     background.padding_right=15 \
     label.drawing=off \


 sketchybar --trigger aerospace_workspace_change




