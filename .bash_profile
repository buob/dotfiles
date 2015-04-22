if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# Git branch in prompt.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1=" 😒  \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] ~ "

export PATH=$PATH:/usr/local/bin

export PATH=/user/local/mysql/bin:$PATH

export EDITOR='vim'

export CLICOLOR=1

export JAVASCRIPT_DRIVER_BROWSER=firefox

export DOCKER_HOST=tcp://localhost:4243

set -o vi

export LSCOLORS=GxFxCxDxBxegedabagaced

alias grom="git rebase origin/master"
alias girom="git rebase -i origin/master"
alias griom="girom"
alias g="ghwd"
alias t="tree -C"

# added by Anaconda 2.0.1 installer
export PATH="/Users/jakebuob/anaconda/bin:$PATH"
