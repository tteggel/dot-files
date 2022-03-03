if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.cabal/bin" ] ; then
    PATH="$HOME/.cabal/bin:$PATH"
fi

if [ -d "$HOME/go/bin" ] ; then
    PATH="$HOME/go/bin:$PATH"
fi

eval $(dircolors $HOME/.dircolors)

unset SOURCE_DATE_EPOCH

export KIDTRON_CHROME_BIN=/run/current-system/sw/bin/google-chrome-unstable
export KIDTRON_FIREFOX_BIN=/run/current-system/sw/bin/firefox
export KIDTRON_SEED_USER=thom+south.west.test@bookcreator.com

