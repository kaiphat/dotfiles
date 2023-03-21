### ENVIROMENTS ###
#set pure_symbol_prompt '$'
#set pure_symbol_prompt ''
set pure_symbol_prompt ❯

#set -gx nvm_default_version v14.18.3
#set -gx nvm_default_version v16.14.2
set -gx nvm_default_version v18.12.0
set -gx ANDROID_HOME $HOME/Android/Sdk
set -gx EDITOR nvim
set -gx MANPAGER 'less'
set -gx PAGER 'nvim -c "set nowrap" -R'
set -gx TERMINAL wezterm
# curl https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo | tic -x -
set -gx TERM xterm-256color
set -gx LUA_DIR /usr/bin/lua
set -gx LD_LIBRARY_PATH /opt/oracle/instantclient_21_8
set -U fish_greeting
set -U ignoreeof true
set -U SXHKD_SHELL sh

function fish_right_prompt
end

function fish_user_key_bindings
  fish_default_key_bindings
end

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
fish_add_path -aP /usr/bin/lua
fish_add_path -aP /usr/bin/i3
fish_add_path -aP /usr/bin/i3bar
fish_add_path -aP $HOME/.cargo/bin
fish_add_path -aP $HOME/.cargo/bin/rustc
fish_add_path -aP $HOME/.krew/bin
fish_add_path -aP $HOME/.local/share/bob/nvim-bin
fish_add_path -aP $HOME/.local/bin/razer-cli
fish_add_path -aP $HOME/.yarn/bin

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

# common #
alias g "git"
alias todo "nvim ~/notes/deals.norg -c \"set signcolumn=no\""
alias notes "nvim ~/notes/notes.norg -c \"set signcolumn=no\""
# tmux #
#alias ssh "wezterm ssh"
alias t "tmux"
alias tn "t new-session -s"
alias ta "t attach-session"
alias td "t detach"
alias st "speedtest"
alias y "yarn"
alias grep "grep -i --color"
alias n "nvim"
alias req "http -p Bb"
alias mkdir "mkdir -p"
alias less "less -MSx4 -FXR --shift 10"
alias ls "ls -A --group-directories-first --color=auto"
alias rm "rm -rf"
alias clip "xclip -selection c"
alias pj "xclip -o | jq '.' | clip"
alias nest "npx @nestjs/cli"
alias nvim-start "nvim --startuptime _s.log -c exit && tail -100 _s.log | bat && rm _s.log"
alias ... "cd ../../"


### PROJECT ALIASES ###
# gladwin
alias gladwin-prod-kuber-namespace "aws eks update-kubeconfig --profile gladwin --region eu-central-1 --name gladwin-frankfurt-prod"
alias gladwin-stage-kuber-namespace "aws eks update-kubeconfig --region eu-central-1 --name gladwin-frankfurt-stage"
alias gladwin-dev-kuber-namespace "cat ~/.kube/config-dev > ~/.kube/config"

alias gladwin-prod-db "kubectl -n 768-gladwin-tech-production port-forward pod/acid-gladwindb-0 8000:5432"
alias gladwin-dev-db "kubectl -n 768-gladwin-tech-develop port-forward pod/acid-gladwindb-0 8000:5432"
alias gladwin-stage-db "kubectl -n 768-gladwin-tech-staging port-forward pod/acid-gladwindb-0 8000:5432"

alias gladwin-prod-redis "kubectl -n 768-gladwin-tech-production port-forward pod/rfr-redis-0 27777:26379"

# green
alias green-prod-db "ssh -4 -L 1234:10.1.1.210:5432 green"
alias green-master-db "ssh -4 -L 1234:localhost:27182 pp-master"

function pq
  xclip -o |\
  string replace -r -a '\\\n' '\n' |\
  string replace -a '\\' '' |\
  clip
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

function ff
  set pattern (string join '*' '' $argv '')
  find . -type f -iwholename $pattern \
  -not -path "*/node_modules/*" \
  -not -path "*/dist/*" \
  -not -path "*/.git/*"
end

#utils functions
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
#eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)

### TMUX ###
function refresh_tmux_vars --on-event="fish_preexec"
  if set -q TMUX
    tmux showenv -s | string replace -rf '^((?:SSH|DISPLAY).*?)=(".*?"); export.*' 'set -gx $1 $2' | source
  end
end

### AUTOSTART ###
#if not set -q TMUX
#  set -g TMUX 1
#  tmux attach -t main || tmux new -s main
#end

#alias ssh "kitty +kitten ssh"

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

#set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/kaiphat/.ghcup/bin # ghcup-env
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/kaiphat/.ghcup/bin # ghcup-env