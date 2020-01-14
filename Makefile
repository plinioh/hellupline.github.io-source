.PHONY: server
server:
	hugo server

.PHONY: submodule-update
submodule-update:
	git submodule foreach git pull origin master

.PHONY: submodule-init
submodule-init:
	git submodule sync --recursive
	git submodule update --init --force --recursive --depth=1

.PHONY: hugo
hugo:
	curl -SsL https://github.com/gohugoio/hugo/releases/download/v0.62.2/hugo_extended_0.62.2_Linux-64bit.tar.gz | tar -xzf- -C ~/.bin/
