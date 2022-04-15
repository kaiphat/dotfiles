### ENVIROMENTS ###
# set pure_symbol_prompt 
# set pure_symbol_prompt 
set pure_symbol_prompt ❯

set -x nvm_default_version v14.18.3
set -x ANDROID_HOME $HOME/Android/Sdk
set -x EDITOR nvim
set -x MANPAGER "most"
set -x PAGER 'nvim -c "set nowrap" -R'
set -x TERMINAL kitty

# paths
fish_add_path -aP $snap_bin_path
fish_add_path -aP $ANDROID_HOME/emulator
fish_add_path -aP $ANDROID_HOME/tools
fish_add_path -aP $ANDROID_HOME/tools/bin
fish_add_path -aP $ANDROID_HOME/platform-tools
fish_add_path -aP /opt/ReactNativeDebugger
fish_add_path -aP /usr/local/go/bin
fish_add_path -aP $HOME/go/bin
fish_add_path -aP /usr/.local/bin
fish_add_path -aP $HOME/.cargo/bin

### ALIASES ###

# docker
alias d "docker"
alias ds "d stop (d ps -q)"
alias dc "docker-compose"
alias dcr "dc restart"
alias du "dc up --force-recreate -d -V $1"
alias dub "dc up --force-recreate --build -d -V $1"

function de --argument container cmd 
  d exec -it $container node_modules/.bin/sequelize $cmd $argv[3..]
end
function dl
  d logs $argv -f -n 99
end
function dlc
  d logs $argv -f -n 999 | \
  awk '/\x1b\[36m/,/\x1b\[0m/'
end
function dps
  d ps -a --format "table {{.ID}}\t{{.Names}}" | \
  grep $argv
end

# common
alias g "git"
alias t "tmux"
alias y "yarn"
alias grep "grep -i --color"
alias n "nvim"
alias mkdir "mkdir -p"
alias less "less -MSx4 -FXR --shift 10"
alias ls "ls -a --group-directories-first --color=auto"
alias rm "rm -rf"
alias clip "xclip -selection c"
alias pj "xclip -o | jq '.' | clip"
alias nvim-start "nvim --startuptime _s.log -c exit && tail -100 _s.log | bat && rm _s.log"

function pq
  xclip -o |\
  string replace -r -a '\\\n' '\n' |\
  string replace -a '\\' '' |\
  clip
end

function fd
  set pattern (string join '*' '' $argv '')
  fdfind -p -g $pattern .
end

function gp -a message
  if test -z "$message"
    echo 'error: empty message'
    return
  end

  set branch (git branch --show-current)

  git add -A 
  and git commit -m "$message" 
  and git push origin $branch
end

function gup -a parent count
  if test -z "$parent"
    echo 'error: empty parrent'
    return
  end
  if test -z "$count"
    echo 'error: there isn\'t count'
    return
  end

  set branch (git branch --show-current)
  set stash_name (date +"%F.%T.$branch")

  git add -A
  and git reset --soft HEAD~$count
  and git stash save $stash_name
  and git checkout $parent
  and git pull origin $parent
  and git branch -D $branch
  and git checkout -b $branch
  and git stash apply
  and git add -A
end


function ff
  set pattern (string join '*' '' $argv '')
  find . -type f -iwholename $pattern \
  -not -path "*/node_modules/*" \
  -not -path "*/dist/*" \
  -not -path "*/.git/*"
end
function di
  set preview "git diff $argv --color=always -- {-1}"
  git diff $argv --name-only | fzf -m --ansi --preview $preview
end

# cd
alias ... "cd ../../"
# function go
#   set paths \
#     rpc_server ~/work/patientory/ptoynetwork-dApp/rpc_server \
#     consumer   ~/work/patientory/consumer-dApp \
#     flact      ~/work/flact \
#     economics  ~/work/patientory/ptoynetwork-airdrop-and-transfer-service \
#     neith      ~/work/patientory/neith-enterprise-portal \
#     hospital   ~/work/patientory/hospital-net \
#     poligon    ~/work/poligon \
#     nvim       ~/.config/nvim \
#     patientory ~/work/patientory
#
#   select cd $paths
# end

function db
  set dbs \
    rpc_server postgres://postgres:postgres@localhost:8000/rpc_server_db

    select pgcli $dbs
end

#common functions
function select
  set cmd $argv[1]
  set dict $argv[2..-1]

  for index in (seq 1 2 (count $dict))
    echo (math "ceil($index/2)") '-' $dict[$index]
  end

  read -p 'echo "Selected number: "' -l number

  $cmd $dict[(math "$number * 2")]
end

### COLORS ###
set fish_color_command '#81A1C1'
set fish_color_match 'red' '--bold' '--background=cyan'
set fish_color_search_match 'red' '--bold' '--background=red'
set fish_pager_color_prefix 'red'
set fish_color_valid_path 
set fish_color_selection 'green' '--background=brblack'
set fish_color_param '#ceceef'
set fish_color_keyword '#ceceef'
set fish_color_autosuggestion '#5c6370'
set fish_color_quote '#6e88a6'
set fish_color_history_current '--bold'
set fish_color_host red
set fish_color_normal
set fish_color_operator 'red'

# set fish_color_cancel '-r'
# set fish_color_comment red
# set fish_color_cwd green
# set fish_color_cwd_root red
# set fish_color_end brmagenta
# set fish_color_error brred
# set fish_color_escape 'red' '--italic'
# set fish_color_host_remote red
# set fish_color_redirection brblue
# set fish_color_status red
# set fish_color_user brgreen

### BREW ###
eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)

### AUTOSTART ###
if not set -q TMUX
  set -g TMUX tmux new-session -d -s base
  eval $TMUX
  tmux attach
end
