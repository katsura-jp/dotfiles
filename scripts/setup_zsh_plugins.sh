#!/bin/bash
# Install oh-my-zsh custom plugins

ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

clone_if_missing() {
  local repo=$1
  local dest=$2
  if [ ! -d "$dest" ]; then
    echo "Installing $(basename $dest)..."
    git clone "$repo" "$dest"
  else
    echo "$(basename $dest) already installed."
  fi
}

clone_if_missing https://github.com/Aloxaf/fzf-tab "$ZSH_CUSTOM/plugins/fzf-tab"
clone_if_missing https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
clone_if_missing https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

echo "Done."
