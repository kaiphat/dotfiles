### ENVIROMENTS ###
# set pure_symbol_prompt 
# set pure_symbol_prompt 
set pure_symbol_prompt ❯

# set -gx nvm_default_version v14.18.3
set -gx nvm_default_version v16.15.0
set -gx ANDROID_HOME $HOME/Android/Sdk
set -gx EDITOR nvim
set -gx MANPAGER "most"
set -gx PAGER 'nvim -c "set nowrap" -R'
set -gx TERMINAL kitty
# set -gx TERMINAL xterm-256color

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
alias di "docker inspect"
alias du "dc up --force-recreate -d -V $1"
alias dub "dc up --force-recreate --build -d -V $1"

function de --argument container cmd 
  d exec -it $container node_modules/.bin/sequelize $cmd $argv[3..]
end
function dl
  d logs $argv -f -n 99
end
function dps
  d ps -a --format "table {{.ID}}\t{{.Names}}" | \
  grep $argv
end

# common
alias g "git"
alias t "tmux attach -t main || tmux new -s main"
alias y "yarn"
alias grep "grep -i --color"
alias n "nvim"
alias ssh "kitty +kitten ssh"
alias mkdir "mkdir -p"
alias less "less -MSx4 -FXR --shift 10"
alias ls "ls -a --group-directories-first --color=auto"
alias rm "rm -rf"
alias clip "xclip -selection c"
alias pj "xclip -o | jq '.' | clip"
alias nest "npx @nestjs/cli"
alias nvim-start "nvim --startuptime _s.log -c exit && tail -100 _s.log | bat && rm _s.log"
alias ... "cd ../../"

function pq
  xclip -o |\
  string replace -r -a '\\\n' '\n' |\
  string replace -a '\\' '' |\
  clip
end

function fd
  set pattern (string join '*' '' $argv '')
  fdfind -HIipg $pattern .
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

# gup develop 1
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

#common functions
function select
  set cmd $argv[1]
  set dict $argv[2..-1]

  for index in (seq 1 2 (count $dict))
    echo (set_color cyan) (math "ceil($index/2)") (set_color blue)'-' (set_color green)$dict[$index]
  end

  read -p 'echo (set_color blue) "Selected number: "' -l number

  $cmd (string split " " $dict[(math "$number * 2")])
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
  tmux attach-session -d -t base
end
