if [ "$(uname)" == "Darwin" ]; then
    . $(brew --prefix asdf)/libexec/asdf.sh
    . $(brew --prefix asdf)/etc/bash_completion.d/asdf.bash
else
    . "$HOME/.asdf/asdf.sh"
    . "$HOME/.asdf/completions/asdf.bash"
fi
