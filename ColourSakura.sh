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

# Export for matching zsh colours
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
SAKURA_RED=`printf "%d" \`echo   "$RED * 255 * $BG_VAL" | bc -q | cut -d . -f 1\``
SAKURA_GREEN=`printf "%d" \`echo "$GREEN * 255 * $BG_VAL" | bc -q | cut -d . -f 1\``
SAKURA_BLUE=`printf "%d" \`echo  "$BLUE * 255 * $BG_VAL" | bc -q | cut -d . -f 1\``
SAKURA_COLOUR=\#$SAKURA_RED$SAKURA_GREEN$SAKURA_BLUE

# Generate config file
FILENAME=ColourSakura-$$.conf
FILEPATH=~/.config/sakura
(
echo "[sakura]"
echo "colorset1_fore=rgb(192, 192, 192)"
echo "colorset1_back=rgba($SAKURA_RED, $SAKURA_GREEN, $SAKURA_BLUE, 0.95)"
echo "font=Terminus 9"
echo "audible_bell=Yes"
echo "visible_bell=No"
echo "blinking_cursor=No"
echo "maximized=No"
echo "word_chars=-A-Za-z0-9,./?%&#_~"
echo "palette=tango"
) > $FILEPATH/$FILENAME

# Run sakura
sakura --config-file=$FILENAME

# Tidy up
rm $FILEPATH/$FILENAME
