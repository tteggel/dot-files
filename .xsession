#!/bin/bash

xrdb -merge $HOME/.Xresources

#Fix java GUI apps.
#wmname LG3D &

#Fix [libre|open]office dialogs
#export SAL_USE_VCLPLUGIN=gen

echo Starting screensaver...
/usr/bin/xscreensaver -no-splash &

echo Setting Caps-lock == mod 4...
setxkbmap -option caps:super

echo UK Keyboard...
setxkbmap gb

echo Starting autocutsel...
autocutsel -fork
autocutsel -selection PRIMARY -fork

echo Starting emacs daemon...
emacs --daemon &

echo Setting cursor...
xsetroot -cursor_name crosshair

echo Starting urxvt deamon...
urxvtd -q -o -f

echo Starting vbox integration...
VBoxClient --clipboard
VBoxClient --display

echo Starting window manager...
exec i3
