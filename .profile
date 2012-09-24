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

# set PATH to include .cabal/bin if it exists
#if [ -d "$HOME/.cabal/bin" ] ; then
#    PATH="$HOME/.cabal/bin:$PATH"
#fi

# Add depot tools to path
if [ -d "$HOME/src/depot_tools" ] ; then
    PATH="$PATH:$HOME/src/depot_tools"
fi

# Node js modules to path
NODE_PATH=$HOME/.node_modules

# Emacs client
EDITOR="emacsclient -c"
VISUAL="emacsclient -c"

eval `dircolors $HOME/.dircolors`

ANDROID_SDK="$HOME/opt/android-sdk-linux"
if [ -d $ANDROID_SDK ] ; then
    PATH="$PATH:$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools"
fi
