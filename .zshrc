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

# Global environment variables
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_TYPE=en_US.UTF-8
export EDITOR="nvim"
export THEME="catppuccin"
export $(cat ~/.env)

# Hostname viz
PS1="🔥 %n %~ $ "

# Friendly consise man pages with examples from "cheat" and tldr
cheat () {
  curl "cheat.sh/$1"
}

# Fix backwards search
bindkey '^R' history-incremental-search-backward

# Install: git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Must be last line
# Install: git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
