set -xeuo pipefail

pushd $(dirname $0)
SCRIPTPATH=$(pwd)
USER_HOME=$HOME

: ${1?"Usage: $0 machine-name"}
test -e $SCRIPTPATH/nix/machines/${1}.nix || exit 99

rm -rf $HOME/.dotfiles
ln -s $SCRIPTPATH/. $HOME/.dotfiles

rm -rf $SCRIPTPATH/nix/machine.nix
ln -s $SCRIPTPATH/nix/machines/${1}.nix $SCRIPTPATH/nix/machine.nix

git submodule update --init --recursive || true

rm -f $HOME/.dircolors
ln -s $SCRIPTPATH/.dircolors $HOME/.dircolors

rm -f $HOME/.Xresources
ln -s $SCRIPTPATH/.Xresources $HOME/.Xresources

rm -f $HOME/.zshenv
ln -s $SCRIPTPATH/.zshenv $HOME/.zshenv

rm -f $HOME/.zshrc
ln -s $SCRIPTPATH/.zshrc $HOME/.zshrc

rm -f $HOME/.tmux.conf
ln -s $SCRIPTPATH/.tmux.conf $HOME/.tmux.conf

rm -rf $HOME/.oh-my-zsh
ln -s $SCRIPTPATH/third_party/oh-my-zsh $HOME/.oh-my-zsh

rm -rf $HOME/.oh-my-zsh/custom/themes/powerlevel10k
mkdir -p ~/.oh-my-zsh/custom/themes
ln -s $SCRIPTPATH/third_party/powerlevel10k $HOME/.oh-my-zsh/custom/themes/powerlevel10k

rm -rf $HOME/.i3
ln -s $SCRIPTPATH/.i3 $HOME/.i3

rm -rf $HOME/.i3status.conf
ln -s $SCRIPTPATH/.i3status.conf $HOME/.i3status.conf

rm -rf $HOME/.emacs.d
ln -s $SCRIPTPATH/third_party/spacemacs $HOME/.emacs.d

rm -rf $HOME/.spacemacs
ln -s $SCRIPTPATH/.spacemacs $HOME/.spacemacs

rm -rf $HOME/.config/termite
mkdir -p $HOME/.config
ln -s $SCRIPTPATH/termite $HOME/.config/termite

rm -rf $HOME/.gitconfig
ln -s $SCRIPTPATH/.gitconfig $HOME/.gitconfig

rm -rf $HOME/.p10k.zsh
ln -s $SCRIPTPATH/.p10k.zsh $HOME/.p10k.zsh

popd

cleanup() {
    popd || true
}
trap cleanup EXIT
