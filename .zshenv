if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.cabal/bin" ] ; then
    PATH="$HOME/.cabal/bin:$PATH"
fi

# Emacs client
EDITOR="emacsclient -ct"
VISUAL="emacsclient -ct"

alias emacs="emacsclient -ct"

eval $(dircolors $HOME/.dircolors)

export JAVA_OPTS="$JAVA_OPTS -Dhttp.proxyHost=127.0.0.1 -Dhttp.proxyPort=3128 -Dhttps.proxyHost=127.0.0.1 -Dhttps.proxyPort=3128"

export GOPATH=$HOME
export GOBIN=$GOPATH/bin

# fn deploy local
alias fdl="fn deploy --app \$FN_APP_NAME --local"

# fn calls list
alias fcl="fn calls list \$FN_APP_NAME"

# fn logs get
alias flg="fn logs get \$FN_APP_NAME"

# fn last log
alias fll="fn calls list \$FN_APP_NAME | tail -n 8 | head -n 1 | cut -f2 -d' ' | xargs fn logs get \$FN_APP_NAME"

gpg-connect-agent updatestartuptty /bye > /dev/null 2>&1
