#!/bin/bash

set -xe

pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd`
popd > /dev/null

sudo apt-get install tmux git privoxy i3 emacs zsh hplip cups spice-client inkscape pulseaudio xinput xinit rxvt-unicode-256color xscreensaver* socat tinyproxy python-setuptools x11-xserver-utils firefox

rm -f $HOME/.dircolors
ln -s $SCRIPTPATH/.dircolors $HOME/.dircolors

rm -f $HOME/.Xresources
ln -s $SCRIPTPATH/.Xresources $HOME/.Xresources

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

mkdir -p $HOME/.config
rm -rf $HOME/.config/powerline
ln -s $SCRIPTPATH/powerline $HOME/.config/powerline

rm -rf $HOME/.i3
ln -s $SCRIPTPATH/.i3 $HOME/.i3

rm -rf $HOME/.i3status
ln -s $SCRIPTPATH/.i3status $HOME/.i3status

rm -rf $HOME/.emacs.d
ln -s $SCRIPTPATH/third_party/emacs-live $HOME/.emacs.d

rm -rf $HOME/.emacs-live.el
ln -s $SCRIPTPATH/.emacs-live.el $HOME/.emacs-live.el

mkdir -p $HOME/.live-packs
rm -rf $HOME/.live-packs/tteggel-pack
ln -s $SCRIPTPATH/third_party/tteggel-pack $HOME/.live-packs/tteggel-pack

mkdir -p $HOME/.fonts
$SCRIPTPATH/third_party/powerline-fonts/install.sh
fc-cache -frv

cd $SCRIPTPATH/third_party/powerline
sudo python setup.py develop
