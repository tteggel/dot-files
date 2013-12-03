#!/bin/bash

pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd`
popd > /dev/null

rm -f $HOME/.conkerorrc
ln -s $SCRIPTPATH/.conkerorrc $HOME/.conkerorrc

rm -f $HOME/.dircolors
ln -s $SCRIPTPATH/.dircolors $HOME/.dircolors

rm -f $HOME/.Xresources
ln -s $SCRIPTPATH/.Xresources $HOME/.Xresources

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

rm -f $HOME/.profile
ln -s $SCRIPTPATH/.profile $HOME/.profile

rm -f $HOME/.zshrc
ln -s $SCRIPTPATH/.zshrc $HOME/.zshrc

rm -f $HOME/.tmux.conf
ln -s $SCRIPTPATH/.tmux.conf $HOME/.tmux.conf

rm -rf $HOME/.oh-my-zsh
ln -s $SCRIPTPATH/third_party/oh-my-zsh $HOME/.oh-my-zsh

find $SCRIPTPATH/third_party/powerline-fonts -name '*.[ot]tf' -exec cp '{}' $HOME/.fonts \;
fc-cache -frv
