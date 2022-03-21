case $- in
  *i*) ;;
    *) return;;
esac

export OSH=/c/Users/user/.oh-my-bash

# theme
eval "$(starship init bash)"

OSH_THEME="pure"
OMB_USE_SUDO=true

completions=(
  git
  composer
  ssh
)

aliases=(
  general
)

plugins=(
  git
  bashmarks
  nvm
  zoxide
  progress
)

source "$OSH"/oh-my-bash.sh

### exports ###
export EDITOR='nvim'

### aliases ###
alias n="nvim"
alias y="yarn"
alias g="git"
alias d="docker"
alias dc="docker-compose"
alias dcr="dc restart $1"
alias grep="grep --color -i"
alias ls="ls -a --group-directories-first --color=auto"
alias rm="rm -rf"
alias ...="cd ../.."
alias du="dc up --force-recreate -d -V $1"
alias dub="dc up --force-recreate --build -d -V $1"

function ds {
  d stop $(d ps -q)
}
function dl { 
  d logs $1 -f -n 99
}
function dps { 
  d ps -a --format "table {{.ID}}\t{{.Names}}" | grep $@
}
