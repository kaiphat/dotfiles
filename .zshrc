export ZSH=$HOME/.oh-my-zsh

DISABLE_AUTO_TITLE="true"

function precmd () {
  window_title="\033]0;${PWD/$HOME/~}\007"
  echo -ne "$window_title"
}

# ZSH_THEME=refined
ZSH_THEME="spaceship"
plugins=(git zsh-autosuggestions sudo web-search copydir history jsontools docker)

# detele underline
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

SPACESHIP_EXEC_TIME_SHOW=false
SPACESHIP_PROMPT_DEFAULT_PREFIX=' '
SPACESHIP_PROMPT_ORDER=(
  dir
  git
)
SPACESHIP_CHAR_PREFIX=' '
SPACESHIP_CHAR_SYMBOL=❯
SPACESHIP_CHAR_SUFFIX=' '
SPACESHIP_GIT_PREFIX=
SPACESHIP_GIT_BRANCH_PREFIX=''
SPACESHIP_GIT_STATUS_PREFIX=' '
SPACESHIP_GIT_STATUS_SUFFIX=''
SPACESHIP_GIT_STATUS_DELETED=
SPACESHIP_GIT_STATUS_RENAMED=
SPACESHIP_DIR_TRUNC_PREFIX=' '
SPACESHIP_DIR_PREFIX=' '
SPACESHIP_GIT_STATUS_STASHED=''
SPACESHIP_PROMPT_FIRST_PREFIX_SHOW=true
SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_PROMPT_ADD_NEWLINE=false

# psql pager
export C1='\x1b[34m'
export NO='\x1b[0m'
export LESS="-iMSx4 -FXR"

# variables
export EDITOR=nvim
export PATH=/usr/local/bin:$PATH
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:/opt/homebrew/bin
export PATH="$PATH:/opt/ReactNativeDebugger"

# brew
# eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# aliases
alias d="docker"
function de() { 
  d exec -it "$1" node_modules/.bin/sequelize "$2";
}
function dl() { 
  d logs "$1" -f -n 99;
}
function dlc() { 
  d logs "$1" -f -n 999 | awk '/\x1b\[36m/,/\x1b\[0m/';
}
alias dps="d ps -a --format \"table {{.ID}}\t{{.Names}}\""
function dpsg() { 
  dps | grep "$1"
}
alias ds="d stop \$(d ps -qa)"
alias dc="docker-compose"
alias dcr="dc restart"

alias y="yarn"
alias n="nvim"
alias ls="ls -a --group-directories-first -w 1 --color=auto"
alias rm="rm -rf"

function go() { 
  ~/bash/goto.sh
}
function db() { 
  ~/bash/psql.sh
}
alias gw="cd ~/work && ls"
alias gp="cd ~/work/patientory && ls"
alias gpo="cd ~/work/poligon && n"
alias gr="cd ~/work/patientory/ptoynetwork-dApp/rpc_server"
alias gcn="cd ~/.config/nvim"

# ~/bash/startup.sh

# nvm
# source ~/.nvm/nvm.sh
export NODE_EXTRA_CA_CERTS="/Library/Application Support/Playtika Corp. IT/Certs/Playtika-SCA.pem"
