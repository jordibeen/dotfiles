# LS aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias k='kubectl'

alias aws-default='export AWS_PROFILE=default'
alias aws-jordaye='export AWS_PROFILE=jordaye'
alias aws-do='export AWS_PROFILE=digitalocean'

alias tsource='tmux source-file ~/.tmux.conf'

# K8s autocomplete
autoload -Uz compinit
compinit
source <(kubectl completion zsh)

