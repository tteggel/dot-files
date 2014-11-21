#!/bin/bash

xrdb -merge $HOME/.Xresources

#Fix java GUI apps.
wmname LG3D &

#Fix [libre|open]office dialogs
export SAL_USE_VCLPLUGIN=gen

echo Starting screensaver...
/usr/bin/xscreensaver -no-splash &

echo Starting trayer...
trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 10 --heighttype pixels --height 18 --transparent true --alpha 0 --tint 0x000000 &

echo Setting background...
feh --bg-scale $HOME/Pictures/bg.jpg

echo Setting Caps-lock == mod 4...
setxkbmap -option caps:super

echo UK Keyboard...
setxkbmap gb

echo Starting autocutsel...
autocutsel -fork
autocutsel -selection PRIMARY -fork

echo Starting pulseaudio...
start-pulseaudio-x11

echo Starting emacs daemon...
emacs --daemon & 

echo Setting cursor...
xsetroot -cursor_name crosshair

echo Setting up mouse...
xinput set-prop 11 "Evdev Middle Button Emulation" 1
xinput set-prop 11 "Evdev Wheel Emulation" 1
xinput set-prop 11 "Evdev Wheel Emulation Button" 3

echo Starting xmonad...
exec xmonad
