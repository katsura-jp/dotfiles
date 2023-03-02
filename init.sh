if [ "$(uname)" == "Darwin" ]; then
  # mac
  brew install git coreutils ripgrep
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install

elif [ "$(expr substr $(uname -s) 1 5)" == "MINGW" ]; then
  # windows
  :
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  # linux
  :
fi

