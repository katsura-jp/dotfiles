# Go (bash/zsh shared) — lazy load for fast shell startup

if [ -d "$HOME/.goenv" ]; then
  export GOENV_ROOT="$HOME/.goenv"
  export PATH="$GOENV_ROOT/bin:$PATH"

  _goenv_init() {
    unset -f goenv go 2>/dev/null
    eval "$(command goenv init -)"
    export PATH="$GOROOT/bin:$PATH"
    export PATH="$PATH:$GOPATH/bin"
  }

  goenv() {
    _goenv_init
    unset -f _goenv_init
    goenv "$@"
  }

  go() {
    _goenv_init
    unset -f _goenv_init
    go "$@"
  }
fi
