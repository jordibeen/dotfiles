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
alias aws-check='export AWS_PROFILE=check'
alias aws-do='export AWS_PROFILE=do'

# K8s
alias k='kubectl'

# Darkmode switch
darkmode () {
    export COLORSCHEME=dark
    tmux set -g @catppuccin_flavour 'frappe'
}
lightmode () {
    export COLORSCHEME=light
    tmux set -g @catppuccin_flavour 'latte'
}

