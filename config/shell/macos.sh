# macOS common settings (bash/zsh shared)

# brew
if [ -f /opt/homebrew/bin/brew ]; then
    eval $(/opt/homebrew/bin/brew shellenv)

    if [ -d $(brew --prefix)/opt/coreutils/libexec/gnubin ]; then
        export PATH=$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH
    fi
fi
