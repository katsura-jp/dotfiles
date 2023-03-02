if [ "$(uname)" == "Darwin" ]; then
  # mac
  brew install coreutils
elif [ "$(expr substr $(uname -s) 1 5)" == "MINGW" ]; then
  # windows
  :
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  # linux
  :
fi

