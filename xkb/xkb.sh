#!/bin/sh

# Update to my custom xkb.
xkbcomp -I$HOME/.xkb ~/.xkb/keymap/mykeymap $DISPLAY 2> /dev/null

# Disable repeating <zenkaku-hankaku>
xset -r 49  > /dev/null 2>&1
