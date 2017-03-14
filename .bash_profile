if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# Git branch in prompt.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1=" 😒  \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] ~ "

export PATH=$PATH:/usr/local/bin

export PATH=/usr/local/mysql/bin:$PATH

export PATH=$PATH:~/.composer/vendor/bin

export EDITOR='vim'

export CLICOLOR=1

export JAVASCRIPT_DRIVER_BROWSER=firefox

export DOCKER_HOST=tcp://192.168.59.103:2375
unset DOCKER_CERT_PATH
unset DOCKER_TLS_VERIFY

export VBOX_HOME=/Applications/VirtualBox.app/Contents/MacOS

set -o vi

export LSCOLORS=GxFxCxDxBxegedabagaced

alias grom="git rebase origin/master"
alias girom="git rebase -i origin/master"
alias griom="girom"
alias g="ghwd"
alias t="tree -C -I node_modules"

gifify() {
  if [[ -n "$1" ]]; then
    if [[ $2 == '--good' ]]; then
      ffmpeg -i $1 -r 10 -vcodec png out-static-%05d.png
      time convert -verbose +dither -layers Optimize -resize 600x600\> out-static*.png  GIF:- | gifsicle --colors 128 --delay=5 --loop --optimize=3 --multifile - > $1.gif
      rm out-static*.png
    else
      ffmpeg -i $1 -s 600x400 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 > $1.gif
    fi
  else
    echo "proper usage: gifify <input_movie.mov>. You DO need to include extension."
  fi
}

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin
export PATH="/usr/local/sbin:$PATH"

export NVM_DIR="/Users/jakebuob/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
