# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="soliah"

source /Users/jakebuob/.dotfiles/helpers/git.zsh

autoload -U colors && colors

_vim_prompt_cmd='%F{blue}> %f%k'
_vim_prompt_ins='%F{green}> %f%k'
_vim_prompt=$_vim_prompt_ins

function zle-keymap-select {
  _vim_prompt="${${KEYMAP/vicmd/${_vim_prompt_cmd}}/(main|viins)/${_vim_prompt_ins}}";
  zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish { _vim_prompt=$_vim_prompt_ins }
zle -N zle-line-finish

function _left_prompt {
  echo $_vim_prompt
}

function _right_prompt {
  local _right_prompt

  if [ "$(_git_in_repo)" -eq 0 ]; then
    if [ "$(_git_any_unstaged)" -eq 0 ] || [ "$(_git_any_uncommited)" -eq 0 ] || [ "$(_git_any_untracked)" -eq 0 ]; then
      _right_prompt="$(_git_get_repo)$(_git_get_path) %F{yellow}$(_git_get_branch)%f%k"
    else
      _right_prompt="$(_git_get_repo)$(_git_get_path) $(_git_get_branch)"
    fi
  else
    _right_prompt=$(echo $PWD | sed -e "s|${HOME}|~|" -e "s|/\(.\)[^/]*|/\1|g" -e "s|/[^/]*$|/$(basename $PWD)|")
  fi

  echo -e "%F{238}$_right_prompt%f%k"
}

PROMPT='$(_left_prompt)'
RPROMPT='$(_right_prompt)'

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
export PATH=$PATH:/usr/local/bin
export PATH="/Users/jakebuob/anaconda/bin:$PATH"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
