# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈   ENVIROMENTS   ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

set -gx DARK_THEME 1

set -Ux PROMPT_CHAR '❯'
set -Ux PROMPT_CHAR '➜'

set pure_symbol_prompt $PROMPT_CHAR

set -gx nvm_default_version v18.16.0
set -gx ANDROID_HOME $HOME/Android/Sdk
set -gx EDITOR nvim
set -gx MANPAGER 'nvim +Man! -c "set nowrap"'
set -gx PAGER 'nvim +Man! -c "set nowrap"'
set -gx TERMINAL wezterm
set -gx TERM xterm-256color
set -gx LUA_DIR /usr/bin/lua
set -gx LD_LIBRARY_PATH /opt/oracle/instantclient_21_8
set -U fish_greeting
set -U ignoreeof true
set -U SXHKD_SHELL sh
set -U XDG_CONFIG_HOME ~/.config

bind \cd delete-char
bind \cw backward-kill-word

function fish_right_prompt
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
fish_add_path -aP $HOME/.local/bin
set -gx PATH $PATH $HOME/.krew/bin

# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈   ALIASES   ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     edit     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
alias edit-aliases "nvim ~/.config/fish/conf.d/aliases.fish"
alias todo "nvim ~/notes/deals.norg -c \"set signcolumn=no\""
alias notes "nvim ~/notes/notes.norg -c \"set signcolumn=no\""

# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     docker     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
alias d "docker"
alias dstop "sudo systemctl stop docker.socket"
function dstart
  sudo systemctl start docker.service
  ds
end
alias ds "d stop (d ps -q)"
alias dc "docker-compose"
alias dcr "dc restart"
alias di "docker inspect"
alias du "dc up --force-recreate -d -V $1"
alias dub "dc up --force-recreate --build -d -V $1"

alias w "watson"
alias wr "w report --day"
alias wstart "watson start"
alias wst "watson stop"
function wry
  set yesterday (date +%Y-%m-%d --date='yesterday')
  w report --from $yesterday --to $yesterday
end

alias g "git"
alias k "kubectl"
alias t "tmux"
alias tn "t new-session -s"
alias ta "t attach-session"
alias td "t detach"
alias st "speedtest"
alias y "yarn"
alias grep "grep -i --color"
alias n "nvim"
alias nread "nvim -c \"set nowrap\""
alias req "http -p mbh"
alias mkdir "mkdir -p"
alias less "less -MSx4 -FXR --shift 10"
alias ls "ls -A --group-directories-first --color=auto"
alias rm "rm -rf"
alias cp "cp -r --verbose"
alias clip "xclip -selection c"
alias pj "xclip -o | jq '.' | clip"
alias nest "npx @nestjs/cli"
alias nvim-start "nvim --startuptime _s.log -c exit && tail -100 _s.log | bat && rm _s.log"
alias ... "cd ../../"

alias enru "trans en:ru -show-original no -show-prompt-message no -show-languages no"
alias ruen "trans ru:en -show-original no -show-prompt-message no -show-languages no"

alias vpn:job:up "sudo wg-quick up ~/vpn.conf"
alias vpn:job:down "sudo wg-quick down ~/vpn.conf"
alias vpn:job-all:up "sudo wg-quick up ~/vpn.all.conf"
alias vpn:job-all:down "sudo wg-quick down ~/vpn.all.conf"

function dl
  d logs $argv -f -n 99
end

function dps
  d ps -a --format "table {{.ID}}\t{{.Names}}" | \
  grep $argv
end

function git-recreate-from -a root_branch
  if test -z "$root_branch"; echo 'error: need a root_branch argument'; return; end

  set branch (git branch --show-current)
  git ch $root_branch
  git bd $branch
  git plh
  git chb $branch
end

function gp -a message
  if test -z "$message"; echo '{message} is not implemented'; return; end

  set branch (git branch --show-current)

  git add -A
  git commit -m "$message"
  git push origin $branch
end

# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈   COLORS   ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

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

# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈   BREW   ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈   TMUX   ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

function refresh_tmux_vars --on-event="fish_preexec"
  if set -q TMUX
    tmux showenv -s | string replace -rf '^((?:SSH|DISPLAY).*?)=(".*?"); export.*' 'set -gx $1 $2' | source
  end
end

# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈   AUTOSTART   ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

zoxide init fish | source

if status is-interactive
and not set -q TMUX
  tmux kill-session -t 0 || true
  tmux attach -t main || tmux new -s main
end

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/kaiphat/.ghcup/bin # ghcup-env
# The next line updates PATH for the Google Cloud SDK
if [ -f '/home/kaiphat/google-cloud-sdk/path.fish.inc' ]; . '/home/kaiphat/google-cloud-sdk/path.fish.inc'; end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/kaiphat/google-cloud-sdk/path.fish.inc' ]; . '/home/kaiphat/google-cloud-sdk/path.fish.inc'; end

