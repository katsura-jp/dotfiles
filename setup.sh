# symbolic link

ln -sf $(realpath .bashrc) $HOME/.bashrc
ln -sf $(realpath .bash_profile) $HOME/.bash_profile
ln -sf $(realpath ./config/nvim) $HOME/.config/nvim
ln -sf $(realpath ./config/wezterm) $HOME/.config/wezterm
ln -sf $(realpath ./config/fish) $HOME/.config/fish
ln -sf $(realpath ./config/powerline-shell) $HOME/.config/powerline-shell
ln -sf $(realpath ./.fzf.bash) $HOME/.fzf.bash
ln -sf $(realpath ./config/fzf) $HOME/.config/fzf

if [ "$(uname)" == "Darwin" ]; then
  # mac
  ln -sf $(realpath ./config/hammerspoon) $HOME/.hammerspoon
elif [ "$(expr substr $(uname -s) 1 5)" == "MINGW" ]; then
  # windows
  :
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  # linux
  :
fi

