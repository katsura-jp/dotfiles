.PHONY install-ubuntu
install-ubuntu:
	mkdir --ignore-fail-on-non-empty ~/.config
	ln -s ~/dotfiles/config/nvim ~/.config/nvim
	ln -s ~/dotfiles/config/wezterm ~/.config/wezterm
