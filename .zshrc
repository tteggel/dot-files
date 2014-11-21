# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# emacs
alias en='emacsclient -c -n'
alias e='emacsclient -n'
alias et='emacsclient -t'
alias emacs='emacsclient -a "" -c'

EDITOR='emacsclient -t -n'

# open
alias open=xdg-open

POWERLINE_RIGHT_A="mixed"
POWERLINE_HIDE_USER_NAME="true"
POWERLINE_DETECT_SSH="true"
#POWERLINE_SHOW_GIT_ON_RIGHT="true"
POWERLINE_HIDE_HOST_NAME="true"

TERM="screen-256color"

PATH=$PATH:$HOME/bin

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git colored-man copydir cp cpanm git-extras gitfast github gnu-utils jira lein pip python ssh-agent svn mercirual themes urltools)

source $ZSH/oh-my-zsh.sh

# ssh wrapper that rename current tmux window to the hostname of the
# remote host.
ssh() {
    # Do nothing if we are not inside tmux or ssh is called without arguments
    if [[ $# == 0 || -z $TMUX ]]; then
        command ssh $@
        return
    fi
    # The hostname is the last parameter (i.e. ${(P)#})
    local remote=${${(P)#}%.*}
    local old_name="$(tmux display-message -p '#W')"
    local renamed=0
    # Save the current name
    if [[ $remote != -* ]]; then
        renamed=1
        tmux rename-window $remote
	tmux setenv -g TMUX_HOSTNAME_$(tmux display -p "#D" | tr -d %) "$remote"
    fi
    command ssh $@
    if [[ $renamed == 1 ]]; then
        tmux rename-window "$old_name"
    fi
}

export PS1=\>'$([ -n "$TMUX" ] && tmux setenv -g TMUX_PWD_$(tmux display -p "#D" | tr -d %) "$PWD" && tmux setenv -g TMUX_VENV_$(tmux display -p "#D" | tr -d %) "$VIRTUAL_ENV")'
