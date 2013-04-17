#!/bin/bash

xrdb -merge $HOME/.Xresources

#Fix java GUI apps.
wmname LG3D &

#Fix [libre|open]office dialogs
export SAL_USE_VCLPLUGIN=gen

echo Starting keyring...
eval $(gnome-keyring-daemon --start)

echo Starting trayer...
trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 10 --heighttype pixels --height 18 --transparent true --alpha 0 --tint 0x000000 &

echo Starting gnome-screensaver...
gnome-screensaver &

echo Starting gnome-settings-daemon...
gnome-settings-daemon &

echo Setting background...
feh --bg-scale $HOME/Pictures/bg.jpg

echo Setting Caps-lock == mod 4
setxkbmap -option caps:super

echo UK Keyboard...
setxkbmap gb

echo Starting autocutsel...
autocutsel -fork
autocutsel -selection PRIMARY -fork

echo Starting pulseaudio...
start-pulseaudio-x11

echo Starting emacs daemon
emacs --daemon

echo Virtualbox guest additions...
VBoxClient --display
VBoxClient --seamless
VBoxClient --clipboard

echo Starting xmonad...
exec xmonad
