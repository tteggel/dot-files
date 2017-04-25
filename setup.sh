#!/bin/bash

set -xe

pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd`
popd > /dev/null

ln -s $SCRIPTPATH $HOME/.dotfiles || true

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

rm -rf $HOME/.oh-my-zsh/custom/themes/powerlevel9k
mkdir -p ~/.oh-my-zsh/custom/themes
ln -s $SCRIPTPATH/third_party/powerlevel9k $HOME/.oh-my-zsh/custom/themes/powerlevel9k

mkdir -p $HOME/.config
rm -rf $HOME/.config/powerline
ln -s $SCRIPTPATH/powerline $HOME/.config/powerline

rm -rf $HOME/.i3
ln -s $SCRIPTPATH/.i3 $HOME/.i3

rm -rf $HOME/.i3status.conf
ln -s $SCRIPTPATH/.i3status.conf $HOME/.i3status.conf

rm -rf $HOME/.emacs.d
ln -s $SCRIPTPATH/third_party/spacemacs $HOME/.emacs.d

rm -rf $HOME/.spacemacs
ln -s $SCRIPTPATH/.spacemacs $HOME/.spacemacs

mkdir -p $HOME/.fonts
#$SCRIPTPATH/third_party/powerline-fonts/install.sh
(cd $SCRIPTPATH/third_party/nerd-fonts && ./install.sh)
fc-cache -frv

cd $SCRIPTPATH/third_party/powerline
sudo python setup.py develop
