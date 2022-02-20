### ENVIROMENTS ###
set -U EDITOR nvim
set -U ANDROID_HOME $HOME/Android/Sdk
set -U pure_symbol_prompt 

# paths
fish_add_path -aP $snap_bin_path
fish_add_path -aP $ANDROID_HOME/emulator
fish_add_path -aP $ANDROID_HOME/tools
fish_add_path -aP $ANDROID_HOME/tools/bin
fish_add_path -aP $ANDROID_HOME/platform-tools
fish_add_path -aP /opt/ReactNativeDebugger
fish_add_path -aP /usr/local/go/bin
fish_add_path -aP $HOME/go/bin

### ALIASES ###

# docker
alias d "docker"
alias ds "d stop (d ps -qa)"
alias dc "docker-compose"
alias dcr "dc restart"
alias du "dc up --force-recreate -d -V $1"
alias dub "dc up --force-recreate --build -d -V $1"

function de --argument container cmd 
  d exec -it $container node_modules/.bin/sequelize $cmd
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
alias y "yarn"
alias n "nvim"
alias less "less -MSx4 -FXR --shift 10"
alias ls "ls -a --group-directories-first --color=auto"
alias rm "rm -rf"
alias clip "xclip -selection c"
function fd
  set pattern (string join '*' '' $argv '')
  fdfind -p -g $pattern .
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
set -U fish_color_command '#81A1C1'
set -U fish_color_match 'red' '--bold' '--background=cyan'
set -U fish_color_search_match '--background=#333945'
set -U fish_color_valid_path
set -U fish_color_selection 'green' '--bold' '--background=brblack'
set -U fish_color_param '#ceceef'
# set -U fish_color_autosuggestion '555' 'brblack'
# set -U fish_color_cancel '-r'
# set -U fish_color_comment red
# set -U fish_color_cwd green
# set -U fish_color_cwd_root red
# set -U fish_color_end brmagenta
# set -U fish_color_error brred
# set -U fish_color_escape 'bryellow' '--bold'
# set -U fish_color_history_current '--bold'
# set -U fish_color_host normal
# set -U fish_color_host_remote yellow
# set -U fish_color_normal normal
# set -U fish_color_operator bryellow
# set -U fish_color_quote yellow
# set -U fish_color_redirection brblue
# set -U fish_color_status red
# set -U fish_color_user brgreen
