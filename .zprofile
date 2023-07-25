# Colorful ls -la
alias ls='ls --color=auto'
alias ll='ls -alF --color'

# Colorful grep
alias grep='grep --color'

# Vi
alias vi='nvim'

# Source zprofile
alias zsource='source ~/.zprofile'

# Source tmux file
alias tsource='tmux source-file ~/.tmux.conf'

# AWS profiles
alias aws-default='export AWS_PROFILE=default'
alias aws-jordaye='export AWS_PROFILE=jordaye'
alias aws-do='export AWS_PROFILE=digitalocean'

# K8s
alias k='kubectl'
# K8s autocompletion
autoload -Uz compinit
compinit
source <(kubectl completion zsh)

