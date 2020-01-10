.PHONY: save publish

.PHONY: server
server:
	hugo server

.PHONY: sync
sync:
	git pull origin

.PHONY: build
build: | sync submodule-init
	hugo --minify

.PHONY: save
save: | build
	git add ./docs
	git commit -m 'update site'

.PHONY: publish
publish: | save
	git push origin

.PHONY: submodule-update
submodule-update:
	git submodule foreach git pull origin master

.PHONY: submodule-init
submodule-init:
	git submodule update --recursive --init


.PHONY: python-server
python-server:
	python3 -m http.server --directory ./docs

.PHONY: hugo
hugo:
	go get github.com/gohugoio/hugo
	go install github.com/gohugoio/hugo
