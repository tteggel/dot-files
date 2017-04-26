#!/bin/bash

set -xeuo pipefail

pushd $(dirname $0)
SCRIPTPATH=$(pwd)

git submodule update --init --recursive

rm -rf $HOME/.dotfiles
ln -s $SCRIPTPATH/. $HOME/.dotfiles

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

mkdir /tmp/termite || true
(
    cd /tmp/termite
    $SCRIPTPATH/third_party/termite-install/termite-install.sh || true
)
rm -rf /tmp/termite

cd $SCRIPTPATH/third_party/powerline
sudo python setup.py develop

rm -rf $SCRIPTPATH/third_party/nerd-fonts-1.0.0
curl -L -o /tmp/nerd-fonts.zip https://github.com/ryanoasis/nerd-fonts/archive/v1.0.0.zip
unzip /tmp/nerd-fonts.zip -d /tmp
rm /tmp/nerd-fonts.zip
(
    cd /tmp/nerd-fonts-1.0.0
    ./install.sh || true
)
rm -rf /tmp/nerd-fonts-1.0.0

popd

cleanup() {
    rm -rf /tmp/nerd-fonts.zip || true
    rm -rf /tmp/nerd-fonts-1.0.0 || true
    rm -rf /tmp/termite || true
    popd || true
}
trap cleanup EXIT
