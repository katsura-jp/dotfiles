
unlink_dotfile () {
  if [ -L ${1} ] ; then
    echo "unlink ${1}"
    unlink ${1}
  fi
}

# bash
unlink_dotfile $HOME/.bashrc
unlink_dotfile $HOME/.bash_profile

# .config
unlink_dotfile $HOME/.config/bash

unlink_dotfile $HOME/.config/nvim
unlink_dotfile $HOME/.config/wezterm
unlink_dotfile $HOME/.config/powerline-shell
unlink_dotfile $HOME/.config/oh-my-posh
unlink_dotfile $HOME/.config/fzf

# $HOME
unlink_dotfile $HOME/.hammerspoon
unlink_dotfile $HOME/.tmux.conf
