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
alias k-prod="KUBECONFIG=~/.kube/config-prod kubectl"
alias k-dev="KUBECONFIG=~/.kube/config-dev kubectl"
alias k-test="KUBECONFIG=~/.kube/config-test kubectl"

eval $(dircolors $HOME/.dircolors)

export JAVA_OPTS="$JAVA_OPTS -Dhttp.proxyHost=127.0.0.1 -Dhttp.proxyPort=3128 -Dhttps.proxyHost=127.0.0.1 -Dhttps.proxyPort=3128"

export GOPATH=$HOME
export GOBIN=$GOPATH/bin

gpg-connect-agent updatestartuptty /bye > /dev/null 2>&1
