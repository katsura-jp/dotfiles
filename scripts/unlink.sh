
unlink_dotfile () {
  if [ -L "${1}" ]; then
    echo "unlink ${1}"
    unlink "${1}"
  fi
}

# bash
unlink_dotfile $HOME/.bashrc
unlink_dotfile $HOME/.bash_profile

# zsh
unlink_dotfile $HOME/.zshrc
unlink_dotfile $HOME/.zprofile

# .config
unlink_dotfile $HOME/.config/shell
unlink_dotfile $HOME/.config/bash
unlink_dotfile $HOME/.config/zsh
unlink_dotfile $HOME/.config/git
unlink_dotfile $HOME/.config/mise

unlink_dotfile $HOME/.config/nvim
unlink_dotfile $HOME/.wezterm.lua
unlink_dotfile $HOME/.config/powerline-shell
unlink_dotfile $HOME/.config/oh-my-posh
unlink_dotfile $HOME/.config/fzf

# $HOME
unlink_dotfile $HOME/.hammerspoon
unlink_dotfile $HOME/.tmux.conf

unlink_dotfile $HOME/.oh-my-zsh/custom/themes/nord.zsh-theme
unlink_dotfile $HOME/.config/starship.toml
