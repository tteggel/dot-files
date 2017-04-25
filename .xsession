#!/bin/bash

xrdb -merge $HOME/.Xresources

#Fix java GUI apps.
#wmname LG3D &

#Fix [libre|open]office dialogs
#export SAL_USE_VCLPLUGIN=gen

echo Starting screensaver...
/usr/bin/xscreensaver -no-splash &

echo UK Keyboard...
setxkbmap gb

echo Setting modifiers...
xmodmap -e 'keycode 108 = Super_L'

#echo Starting autocutsel...
#autocutsel -fork
#autocutsel -selection PRIMARY -fork

echo Starting emacs daemon...
emacs --daemon --insecure &

echo Setting cursor...
xsetroot -cursor_name crosshair

echo Starting urxvt deamon...
urxvtd -q -o -f

echo Starting vmware integration...
vmhgfs-fuse .host:/Shared /mnt/host
/usr/bin/vmware-user-suid-wrapper &

echo Starting window manager...
exec i3
