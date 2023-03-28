.PHONY: link
link:
	mkdir -p ~/.config
	bash ./scripts/link.sh
	. ~/.bash_profile
.PHONY: unlink
unlink:
	bash ./scripts/unlink.sh
