# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

# npm global packages
if command -v npm &> /dev/null; then
  export PATH=$(npm prefix --location=global)/bin:$PATH
fi

