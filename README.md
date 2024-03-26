# jordibeen dotfiles

## Configure git
Set up aliasing
```sh
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
git clone --bare git@github.com:jordibeen/dotfiles.git $HOME/.dotfiles
```

Hide untracked files
```sh
dotfiles config --local status.showUntrackedFiles no
```

## Install Dependencies
- [kitty](https://github.com/kovidgoyal/kitty)
- [neovim](https://github.com/neovim/neovim)
- [tmux](https://github.com/tmux/tmux)
- [tpm](https://github.com/tmux-plugins/tpm)
- [brew](https://github.com/Homebrew/brew)
- [mistral](https://ollama.com/library/mistral)

### zsh
```sh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
```

### brew
```sh
cat .brew/requirements.txt | xargs brew install && cat .brew/casks.txt | xargs brew install --cask
```
