# symbolic link

ln -sf $(realpath .bashrc) $HOME/
ln -sf $(realpath .bash_profile) $HOME/
ln -sf $(realpath ./config/nvim) $HOME/.config/
ln -sf $(realpath ./config/wezterm) $HOME/.config/
ln -sf $(realpath ./config/powerline-shell) $HOME/.config/
ln -sf $(realpath ./.fzf.bash) $HOME/
ln -sf $(realpath ./config/fzf) $HOME/.config/
ln -sf $(realpath .tmux.conf) $HOME/

if [ "$(uname)" == "Darwin" ]; then
  # mac
  ln -sf $(realpath ./.hammerspoon) $HOME/.hammerspoon
elif [ "$(expr substr $(uname -s) 1 5)" == "MINGW" ]; then
  # windows
  :
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  # linux
  :
fi

