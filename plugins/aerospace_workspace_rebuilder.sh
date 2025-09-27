#!/usr/bin/env bash
set -euo pipefail
trap 'echo "ERR at line $LINENO (last cmd: $BASH_COMMAND)" >&2' ERR
set -x
source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icon_map.sh"

STATE_DIR="/tmp/aero_ws_db"
mkdir -p "$STATE_DIR"
BUF_FILE="$STATE_DIR/buf"                    

CURR_BUF="$(cat "$BUF_FILE" 2>/dev/null || echo "A")"
if [ "$CURR_BUF" = "A" ]; then NEW_BUF="B"; else NEW_BUF="A"; fi

add() { CMD+=( "$@" ); }

CMD=(sketchybar --animate sin 0)

CMD+=( --remove "/^space${NEW_BUF}\..*/" )
CMD+=( --remove "/^space-app${NEW_BUF}\..*/" )
CMD+=( --remove "/^space-spacer${NEW_BUF}\..*/" )

FOCUSED="$(aerospace list-workspaces --focused 2>/dev/null | head -n1)"
WORKSPACES_WITH_WINDOWS="$(aerospace list-windows --all --format '%{workspace}')"
ALL_WORKSPACES=$(printf '%s\n%s\n' "$WORKSPACES_WITH_WINDOWS" "$FOCUSED" | sort -n | uniq | grep -v '^$' || true)
MONITORS="$(aerospace list-monitors --format '%{monitor-id}' || true)"
if [ -z "$MONITORS" ]; then MONITORS="1"; fi
MONITOR_COUNT="$(echo "$MONITORS" | wc -w | tr -d ' ')"

get_display_number() {
  case "$MONITOR_COUNT" in
    1) echo 1 ;;
    2) [ "$1" = "2" ] && echo 2 || echo 1 ;;
    3)
      case "$1" in
        1) echo 2 ;;
        2) echo 3 ;;
        3) echo 1 ;;
        *) echo 1 ;;
      esac
      ;;
    *) echo 1 ;;
  esac
}

ITEM_ORDER=1

for monitor in $MONITORS; do
  DISPLAY_NUM=$(get_display_number "$monitor")
  MONITOR_WORKSPACES="$(aerospace list-workspaces --monitor "$monitor" || true)"

  CURR_WORKSPACES=()
  for workspace in $MONITOR_WORKSPACES; do
    if echo "$ALL_WORKSPACES" | grep -q "^$workspace$"; then
      CURR_WORKSPACES+=("$workspace")
    fi
  done

  for sid in "${CURR_WORKSPACES[@]:-}"; do
    if [ "$sid" = "$FOCUSED" ]; then
      BG_HEIGHT=40;
      BG_COLOR=$BLACK;
      FONT="SF Pro Text:Regular:19.0"; 
      ICON_FONT="sketchybar-app-font:Regular:18.0";
      ICON_PAD=12;
      ICON_BG_HEIGHT=22;
      TXT_COL=$WHITE;
    else
        BG_HEIGHT=20; 
        BG_COLOR=$BLACK; 
        FONT="SF Pro Text:Regular:13.0"; 
        ICON_FONT="sketchybar-app-font:Regular:12.0";
        ICON_PAD=8;
        ICON_BG_HEIGHT=20;
        TXT_COL=$GREY;
    fi

    ws_name="space${NEW_BUF}.$sid"

    CMD+=( --add item "$ws_name" left
           --subscribe "$ws_name" aerospace_workspace_change
           --set "$ws_name" \
             display="$DISPLAY_NUM" \
             icon="$sid" \
             icon.padding_left=22 \
             icon.padding_right=22 \
             icon.font="$FONT" \
             icon.color=$TXT_COL \
             label.padding_right=33 \
             background.color=$BG_COLOR \
             background.corner_radius=17 \
             background.height=$BG_HEIGHT \
             background.drawing=on \
             height=60 \
             label.font="$FONT" \
             label.background.height=30 \
             label.background.drawing=on \
             label.background.color=$BG_COLOR \
             label.background.corner_radius=20 \
             label.drawing=off \
             click_script="aerospace workspace $sid"
    )

    APPS="$(aerospace list-windows --workspace "$sid" --format '%{app-name}' | sort | uniq || true)" 
    APP_COUNT=0
    if [ -n "$APPS" ]; then
      while IFS= read -r app; do
        [ -z "$app" ] && continue
        APP_COUNT=$((APP_COUNT + 1))
        __icon_map "$app"; APP_ICON="${icon_result:-󰘔}" 
        app_name="space-app${NEW_BUF}.$sid.$APP_COUNT"
        CMD+=( --add item "$app_name" left
               --set "$app_name" \
                 display="$DISPLAY_NUM" \
                 icon="$APP_ICON" \
                 icon.font="$ICON_FONT" \
                 icon.padding_left=$ICON_PAD \
                 icon.color=$TXT_COL\
                 label.drawing=off \
                 background.height=$ICON_BG_HEIGHT\
                 background.color=$BG_COLOR \
                 background.drawing=on\
                 y_offset=$((10* ITEM_ORDER)) \
                 click_script="aerospace workspace $sid"
        )
        ITEM_ORDER=$((ITEM_ORDER + 1))
      done <<< "$APPS"
    fi

    spacer_name="space-spacer${NEW_BUF}.$sid"
    CMD+=( --add item "$spacer_name" left
           --set "$spacer_name" \
             display="$DISPLAY_NUM" \
             icon="" \
             label="" \
             icon.drawing=off \
             label.drawing=off \
             background.color=$BG_COLOR \
             background.height=5 \
             background.drawing=on \
             y_offset=$((10* ITEM_ORDER))
    )

    ITEM_ORDER=$((ITEM_ORDER + 1))
  done
done

# Single atomic swap:
# - turn OFF current buffer
# - turn ON new buffer
CMD+=( --set "/^space${CURR_BUF}\..*/" drawing=off )
CMD+=( --set "/^space-app${CURR_BUF}\..*/" drawing=off )
CMD+=( --set "/^space-spacer${CURR_BUF}\..*/" drawing=off )

CMD+=( --set "/^space${NEW_BUF}\..*/" drawing=on )
CMD+=( --set "/^space-app${NEW_BUF}\..*/" drawing=on )
CMD+=( --set "/^space-spacer${NEW_BUF}\..*/" drawing=on )


echo "args: ${#CMD[@]}" >&2
printf '%q ' "${CMD[@]}" >&2; echo >&2
# Apply the swap
"${CMD[@]}"

# Persist new visible buffer


