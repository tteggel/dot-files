# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.cabal/bin" ] ; then
    PATH="$HOME/.cabal/bin:$PATH"
fi

# Emacs client
EDITOR="emacsclient -ct"
VISUAL="emacsclient -ct"

alias emacs="/usr/bin/emacsclient -ct"

eval `dircolors $HOME/.dircolors`

export http_proxy=http://127.0.0.1:8118
export https_proxy=$http_proxy
export PS1=\$ '$([ -n "$TMUX" ] && tmux setenv -g TMUX_PWD_$(tmux display -p "#D" | tr -d %) "$PWD" && tmux setenv -g TMUX_VENV_$(tmux display -p "#D" | tr -d %) "$VIRTUAL_ENV" && tmux refresh-client -S)'

export JAVA_OPTS="$JAVA_OPTS -Dhttp.proxyHost=127.0.0.1 -Dhttp.proxyPort=8118 -Dhttps.proxyHost=127.0.0.1 -Dhttps.proxyPort=8118"
