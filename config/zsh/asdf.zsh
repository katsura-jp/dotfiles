if [ "$(uname)" = "Darwin" ]; then
    _asdf_prefix="$(brew --prefix asdf)"
    . "$_asdf_prefix/libexec/asdf.sh"
    . "$_asdf_prefix/etc/bash_completion.d/asdf"
    unset _asdf_prefix
else
    . "$HOME/.asdf/asdf.sh"
    . "$HOME/.asdf/completions/asdf"
fi