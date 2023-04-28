.PHONY: link
link:
	mkdir -p ~/.config
	bash ./scripts/link.sh
	. ~/.bash_profile
.PHONY: unlink
unlink:
	bash ./scripts/unlink.sh

.PHONY: download_fonts
download_fonts:
	bash ./scripts/download_fonts.sh