# Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
New-Alias -Name n -Value nvim
New-Alias -Name d -Value docker
New-Alias -Name dc -Value docker-compose
New-Alias -Name g -Value git

Set-Location D:\Work
# install scoop https://scoop.sh/
# https://ohmyposh.dev/docs/prompt
# scoop install https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/oh-my-posh.json
oh-my-posh prompt init pwsh --config https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/v$(oh-my-posh --version)/themes/jandedobbeleer.omp.json | Invoke-Expression
# Install-Module posh-git -Scope CurrentUser
Import-Module posh-git



