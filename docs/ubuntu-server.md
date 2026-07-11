```zsh
[ ! -d "$HOME/.local/bin" ] && mkdir -p "$HOME/.local/bin"
[ ! -d "$HOME/.local/share/fonts" ] && mkdir -p "$HOME/.local/share/fonts"

echo "export PATH=$PATH:$HOME/.local/bin" >> $HOME/.zshrc
curl -sS https://starship.rs/install.sh | sh -s -- -b ~/.local/bin -y
echo 'eval "$(starship init zsh)"' >> $HOME/.zshrc
starship preset gruvbox-rainbow -o $HOME/.config/starship.toml
exec $SHELL -l
```
