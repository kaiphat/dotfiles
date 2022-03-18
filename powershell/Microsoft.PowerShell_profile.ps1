function ds {
  docker stop $(docker ps -q)
}
function dcr {
  docker-compose restart @args
}
function gw {
  cd D:\\Work
}
function dps {
  d ps -a --format "table {{.ID}}\t{{.Names}}" | grep -i --color $args
}
function dl {
  d logs $args -f -n 99
}

New-Alias -Name n -Value nvim
New-Alias -Name d -Value docker
New-Alias -Name dc -Value docker-compose
New-Alias -Name g -Value git
New-Alias -Name y -Value yarn
# New-Alias -Name grep -Value grep

# Set-Location D:\Work
oh-my-posh prompt init pwsh --config ~/.posh-theme.json | Invoke-Expression
Import-Module posh-git



