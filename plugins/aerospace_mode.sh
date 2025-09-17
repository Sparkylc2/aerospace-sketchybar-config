#!/usr/bin/env sh
source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"




case "$SENDER" in
    "aerospace_mode")
        MODE="$MODE"
        ;;
    *)
        MODE="M"
        ;;
esac

case "$MODE" in
    "M")
        ICON="$AEROSPACE_MAIN"
        COLOR="$GREEN"
        BG_COLOR="$GREY"
        ;;
    "P")
        ICON="$AEROSPACE_PANE"
        COLOR="$BLUE"
        BG_COLOR="$GREY"
  
        ;;
    "L")
        ICON="$AEROSPACE_LAYOUT"
        COLOR="$MAGENTA"
        BG_COLOR="$GREY"
  
        ;;
    "R")
        ICON="$AEROSPACE_RESIZE"
        COLOR="$YELLOW"
        BG_COLOR="$GREY"
  
        ;;
    *)
        ICON="?"
        COLOR="$WHITE"
        BG_COLOR="$GREY" 
        ;;
esac


sketchybar --set $NAME \
           label="$MODE" \
           icon="$ICON" \
           icon.color="$COLOR" \
           label.color="$COLOR" \
           background.color="$BG_COLOR" \
           
