# symbolic link

link_dotfile() {
  local src=$(realpath "$1")
  local dest="$2"

  if [ -d "$dest" ] && [ ! -L "$dest" ]; then
    echo "WARNING: $dest is a real directory, skipping (remove manually if needed)"
    return 1
  fi

  ln -sfn "$src" "$dest"
  echo "linked $dest -> $src"
}

# bash
link_dotfile settings/bash/.bashrc $HOME/.bashrc
link_dotfile settings/bash/.bash_profile $HOME/.bash_profile

# zsh
link_dotfile settings/zsh/.zshrc $HOME/.zshrc
link_dotfile settings/zsh/.zprofile $HOME/.zprofile

# .config
link_dotfile ./config/shell $HOME/.config/shell
link_dotfile ./config/bash $HOME/.config/bash
link_dotfile ./config/zsh $HOME/.config/zsh
link_dotfile ./config/git $HOME/.config/git
link_dotfile ./config/mise $HOME/.config/mise

link_dotfile ./config/nvim $HOME/.config/nvim
link_dotfile ./config/wezterm $HOME/.config/wezterm
link_dotfile ./config/powerline-shell $HOME/.config/powerline-shell
link_dotfile ./config/oh-my-posh $HOME/.config/oh-my-posh
link_dotfile ./config/fzf $HOME/.config/fzf

# $HOME
link_dotfile ./config/tmux/.tmux.conf $HOME/.tmux.conf
link_dotfile ./config/hammerspoon $HOME/.hammerspoon

# oh-my-zsh theme (create parent directory if oh-my-zsh is installed)
if [ -d "$HOME/.oh-my-zsh" ]; then
  mkdir -p $HOME/.oh-my-zsh/custom/themes
  link_dotfile ./config/oh-my-zsh/custom/themes/nord.zsh-theme $HOME/.oh-my-zsh/custom/themes/nord.zsh-theme
fi
link_dotfile ./config/starship/starship.toml $HOME/.config/starship.toml
