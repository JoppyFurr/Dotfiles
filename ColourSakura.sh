#!/bin/bash

# Generate colour
HUE=$[ $RANDOM % 3600 ]
HUE=`echo "$HUE / 10" | bc -lq`
BG_VAL="0.10" # Change this to go darker/lighter

# Convert hue to RGB ( Generic algorithm found all over Google )
HUE=`echo "$HUE / 60" | bc -lq`
F=`echo "$HUE % 1" | bc -q`
Q=`echo "( 1 - $F )" | bc -q`
T=`echo "$F" | bc -q`

case "`echo $HUE | cut -d . -f 1`" in
0)  RED=1
    GREEN=$T
    BLUE=0
    ;;
1)
    RED=$Q
    GREEN=1
    BLUE=0
    ;;
2)
    RED=0
    GREEN=1
    BLUE=$T
    ;;
3)
    RED=0
    GREEN=$Q
    BLUE=1
    ;;
4)
    RED=$T
    GREEN=0
    BLUE=1
    ;;
*) # 5)
    RED=1
    GREEN=0
    BLUE=$Q
    ;;
esac

# Export for zsh
ZSH_VAL=0.6
ZSH_RED=`printf "%.1d" \`echo   "$RED * 5 * $ZSH_VAL" | bc -q | cut -d . -f 1\``
ZSH_GREEN=`printf "%.1d" \`echo "$GREEN * 5 * $ZSH_VAL" | bc -q | cut -d . -f 1\``
ZSH_BLUE=`printf "%.1d" \`echo  "$BLUE * 5 * $ZSH_VAL" | bc -q | cut -d . -f 1\``

# Blue is a bit dark, so add some green
if [ $BLUE == 1 -a $ZSH_GREEN == 0 ] ; then
    ZSH_GREEN=1
fi

ZSH_COLOUR=`echo "36 * $ZSH_RED + 6 * $ZSH_GREEN + $ZSH_BLUE + 16" | bc -q`
export LC_COLOUR_THEME=$ZSH_COLOUR

# Convert from float to hex
SAKURA_RED=`printf "%.2x" \`echo   "$RED * 255 * $BG_VAL" | bc -q | cut -d . -f 1\``
SAKURA_GREEN=`printf "%.2x" \`echo "$GREEN * 255 * $BG_VAL" | bc -q | cut -d . -f 1\``
SAKURA_BLUE=`printf "%.2x" \`echo  "$BLUE * 255 * $BG_VAL" | bc -q | cut -d . -f 1\``
SAKURA_COLOUR=\#$SAKURA_RED$SAKURA_GREEN$SAKURA_BLUE

# Generate config file
FILENAME=ColourSakura-$$.conf
FILEPATH=~/.config/sakura
(
echo "[sakura]"
echo "colorset1_fore=#c0c0c0"
echo "colorset1_back=$SAKURA_COLOUR"
echo "backalpha=65535"
echo "opacity_level=80"
echo "fake_transparency=Yes"
echo "background=none"
echo "font=Terminus 9"
echo "show_always_first_tab=No"
echo "scrollbar=false"
echo "closebutton=false"
echo "audible_bell=Yes"
echo "visible_bell=No"
echo "blinking_cursor=No"
echo "borderless=No"
echo "maximized=No"
echo "word_chars=-A-Za-z0-9,./?%&#_~"
echo "palette=tango"
echo "add_tab_accelerator=5"
echo "del_tab_accelerator=5"
echo "switch_tab_accelerator=8"
echo "copy_accelerator=5"
echo "scrollbar_accelerator=5"
echo "open_url_accelerator=5"
echo "add_tab_key=T"
echo "del_tab_key=W"
echo "prev_tab_key=Left"
echo "next_tab_key=Right"
echo "new_window_key=N"
echo "copy_key=C"
echo "paste_key=V"
echo "scrollbar_key=S"
echo "fullscreen_key=F11"
echo "resize_grip=false"
echo "tabs_on_bottom=false"
echo "less_questions=false"
echo "cursor_type=0"
echo "move_tab_accelerator=5"
echo "font_size_accelerator=4"
echo "set_tab_name_accelerator=5"
echo "set_tab_name_key=N"
echo "icon_file=terminal-tango.svg"
) > $FILEPATH/$FILENAME

# Run sakura
sakura --config-file=$FILENAME

# Tidy up
rm $FILEPATH/$FILENAME
