#!/bin/sh

xkbcomp -I$HOME/.xkb ~/.xkb/keymap/mykeymap $DISPLAY 2> /dev/null
