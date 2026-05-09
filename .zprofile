# PATH setup
export PATH=/opt/homebrew/bin:$PATH

# Homebrew
[[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

# Cargo
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

# Language/locale
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_TYPE=en_US.UTF-8

# Global tools
export EDITOR="nvim"
export THEME="catppuccin"

# fzf navigation
export FZF_DEFAULT_OPTS='
  --bind=ctrl-j:down,ctrl-k:up
  --bind=ctrl-d:half-page-down,ctrl-u:half-page-up
'

# point C compiler to homebrew's openssl (needed for some native Rust crates)
export OPENSSL_DIR=$(brew --prefix openssl)
export CFLAGS="-I${OPENSSL_DIR}/include"
export LDFLAGS="-L${OPENSSL_DIR}/lib"
