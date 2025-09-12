export PATH=/opt/homebrew/bin:$PATH

# Tracking dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# python3 as default
alias python=/opt/homebrew/bin/python3

# Use modern completion system
autoload -U +X bashcompinit && bashcompinit

# K8s autocompletion
autoload -Uz compinit
compinit
source <(kubectl completion zsh)

# docker autocompletion
# (first store docker's completion script using 'docker completion zsh > ~/.zsh/completions/_docker')
FPATH="$HOME/.zsh/completions:$FPATH"

# Global environment variables
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_TYPE=en_US.UTF-8
export EDITOR="nvim"
export THEME="catppuccin"
export $(cat ~/.env)

# Hostname viz
setopt PROMPT_SUBST

# catppuccin
local peach='%F{#fab387}'
local mauve='%F{#cba6f7}'
local blue='%F{#89b4fa}'
local yellow='%F{#f9e2af}'
local text='%F{#cdd6f4}'
local reset='%f'

PS1="${peach}🔥${reset} ${mauve}%n${reset} ${blue}%~${reset}${yellow}\$(git branch --show-current 2>/dev/null | sed 's/.*/ (&)/')${reset}${text} \$ ${reset}"


# Friendly consise man pages with examples from "cheat" and tldr
cheat () {
  curl "cheat.sh/$1"
}

# Fix cursor shape after every command
precmd() {
    printf '\e[5 q'
}

# Fix backwards search
bindkey '^R' history-incremental-search-backward

# Install: git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Must be last line
# Install: git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
