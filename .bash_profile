export PATH=/bin:/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:$PATH

export EDITOR='subl -w'

export WEEK_START_DAY=:saturday

source ~/.rvm/scripts/rvm

PS1="[\W:]$ "
alias rake="bundle exec rake"

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi
