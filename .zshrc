# Options
setopt PROMPT_SUBST

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_SPACE

# Autocompletion
autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit
FPATH="$HOME/.zsh/completions:$FPATH"
# add docker autocompletion with 'docker completion zsh > ~/.zsh/completions/_docker'
# add k8s autocompletion with 'kubectl completion zsh > ~/.zsh/completions/_kubectl'

# Prompt
local peach='%F{#fab387}'
local mauve='%F{#cba6f7}'
local blue='%F{#89b4fa}'
local yellow='%F{#f9e2af}'
local text='%F{#cdd6f4}'
local reset='%f'
PS1="${peach}🔥${reset} ${mauve}%n${reset} ${blue}%~${reset}${yellow}\$(git branch --show-current 2>/dev/null | sed 's/.*/ (&)/')${reset}${text} \$ ${reset}"

# Aliases
alias ls='ls --color=auto'
alias ll='ls -alF --color'
alias grep='grep --color'
alias vi='nvim'
alias zsource='source ~/.zshrc && source ~/.zprofile'
alias tsource='tmux source-file ~/.tmux.conf'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias python='/opt/homebrew/bin/python3'
alias k='kubectl'

# AWS profiles
alias aws-default='export AWS_PROFILE=default'
alias aws-check='export AWS_PROFILE=check'
alias aws-do='export AWS_PROFILE=do'

# Functions
darkmode() {
    export COLORSCHEME=dark
    tmux set -g @catppuccin_flavour 'frappe'
}

lightmode() {
    export COLORSCHEME=light
    tmux set -g @catppuccin_flavour 'latte'
}

cheat() {
    curl "cheat.sh/$1"
}

fzf-history-search() {
    local cmd
    cmd=$(history 1 | awk '{$1=""; print substr($0,2)}' | awk '!seen[$0]++' | fzf --height 20 --reverse --query="$BUFFER")
    if [[ -n $cmd ]]; then
        BUFFER="$cmd"
        CURSOR=${#BUFFER}
    fi
    zle reset-prompt
}
zle -N fzf-history-search
bindkey '^R' fzf-history-search

precmd() {
    # fix cursor shape
    printf '\e[5 q'

    # move cursor to bottom
    printf '\e[999;1H'
}

# Load private .env file
[[ -f ~/.env ]] && export $(grep -v '^#' ~/.env | xargs)

# Plugins (must be last)
# install with 'git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions'
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# install with 'git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting'
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
