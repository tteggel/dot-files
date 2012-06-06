#!/bin/bash

#xrdb -merge .Xresources

#Fix java GUI apps.
wmname LG3D &

#Fix [libre|open]office dialogs
export SAL_USE_VCLPLUGIN=gen

echo Starting keyring...
gnome-keyring-daemon &

echo Starting trayer...
trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 10 --heighttype pixels --height 18 --transparent true --alpha 0 --tint 0x000000 &

echo Starting gnome-screensaver...
gnome-screensaver &

echo Starting gnome-settings-daemon...
gnome-settings-daemon &

if [ -x /usr/bin/gnome-power-manager ] ; then
   sleep 1
   echo Starting gnome-power-manager...
   gnome-power-manager &
fi

if [ -x /usr/bin/nm-applet ] ; then
   echo Starting nm-applet...
   nm-applet --sm-disable &
fi

echo Starting gnome-volume-control...
gnome-sound-applet &

echo Setting background...
feh --bg-scale /home/tleggett/Pictures/hr-air-1.jpg

#echo Starting compositing...
#xcompmgr -c -t-5 -l-5 -l4.2 -r.55 -f &

echo Turn off touchpad...
synclient TouchPadOff=1

if [ -f ~/.xmodmaprc ]; then
    echo Setting Caps-lock == mod 4
    xmodmap ~/.xmodmaprc
fi

echo Starting blueman-applet...
blueman-applet &

echo Starting autocutsel...
autocutsel -fork
autocutsel -selection PRIMARY -fork

echo Starting pulseaudio...
start-pulseaudio-x11

echo Starting xmonad...
exec xmonad
