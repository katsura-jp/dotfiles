# ~/.zprofile: executed by zsh for login shells.

if [ -f ~/.zshrc ]; then
  . ~/.zshrc
fi

# direnv
if command -v direnv > /dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# asdf
if [ -f $HOME/.config/zsh/asdf.zsh ]; then
  . $HOME/.config/zsh/asdf.zsh
fi
