#!/bin/bash

pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd`
popd > /dev/null

rm -f $HOME/.conkerorrc
ln -s $SCRIPTPATH/.conkerorrc $HOME/.conkerorrc

rm -f $HOME/.dircolors
ln -s $SCRIPTPATH/.dircolors $HOME/.dircolors

rm -f $HOME/.Xdefaults
ln -s $SCRIPTPATH/.Xdefaults $HOME/.Xdefaults

rm -f $HOME/.xmobarrc
ln -s $SCRIPTPATH/.xmobarrc $HOME/.xmobarrc

rm -rf $HOME/.xmonad
ln -s $SCRIPTPATH/.xmonad $HOME/.xmonad

rm -f $HOME/.xsession
ln -s $SCRIPTPATH/.xsession $HOME/.xsession

rm -f $HOME/.bash_aliases
ln -s $SCRIPTPATH/.bash_aliases $HOME/.bash_aliases

rm -f $HOME/.bashrc
ln -s $SCRIPTPATH/.bashrc $HOME/.bashrc
