# symbolic link

# bashrc
ln -sf $(realpath settings/bash/.bashrc) $HOME/.bashrc
ln -sf $(realpath settings/bash/.bash_profile) $HOME/.bash_profile

# .config
ln -sf $(realpath ./config/bash) $HOME/.config/bash

ln -sf $(realpath ./config/nvim) $HOME/.config/nvim
ln -sf $(realpath ./config/wezterm) $HOME/.config/wezterm
ln -sf $(realpath ./config/powerline-shell) $HOME/.config/powerline-shell
ln -sf $(realpath ./config/oh-my-posh) $HOME/.config/oh-my-posh
ln -sf $(realpath ./config/fzf) $HOME/.config/fzf

# $HOME
ln -sf $(realpath ./config/tmux/.tmux.conf) $HOME/.tmux.conf
ln -sf $(realpath ./config/hammerspoon) $HOME/.hammerspoon
