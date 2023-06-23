# pyenv

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# rye
if [ -f $HOME/.rye/env ]; then
  . "$HOME/.rye/env"
fi
