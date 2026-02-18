# macOS bash-specific settings
# NOTE: Homebrew init and coreutils are in config/shell/macos.sh (shared)

if [ -f /opt/homebrew/bin/brew ]; then
    # gcloud
    if [ -d $(brew --prefix)/share/google-cloud-sdk ]; then
        . "$(brew --prefix)/share/google-cloud-sdk/path.bash.inc"
    fi
    # bash_completion
    if [ -r $(brew --prefix)/etc/profile.d/bash_completion.sh ]; then
        . "$(brew --prefix)/etc/profile.d/bash_completion.sh"
    fi
fi
