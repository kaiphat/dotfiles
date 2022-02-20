New-Alias -Name n -Value nvim
New-Alias -Name d -Value docker
New-Alias -Name dc -Value docker-compose
New-Alias -Name g -Value git

Set-Location D:\Work
Import-Module oh-my-posh
Import-Module posh-git
Set-PoshPrompt -Theme ~/.posh-theme.json


