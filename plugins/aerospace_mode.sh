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
        BG_COLOR="0x33625e5a"  
        ;;
    "P")
        ICON="$AEROSPACE_PANE"
        COLOR="$BLUE"
        BG_COLOR="0x33625e5a"  
        ;;
    "L")
        ICON="$AEROSPACE_LAYOUT"
        COLOR="$MAGENTA"
        BG_COLOR="0x33625e5a"  
        ;;
    "R")
        ICON="$AEROSPACE_RESIZE"
        COLOR="$YELLOW"
        BG_COLOR="0x33625e5a"  
        ;;
    *)
        ICON="?"
        COLOR="$WHITE"
        BG_COLOR="0x00000000"  
        ;;
esac


sketchybar --set $NAME \
           label="$MODE" \
           icon="$ICON" \
           icon.color="$COLOR" \
           label.color="$COLOR" \
           background.color="$BG_COLOR" \
           
