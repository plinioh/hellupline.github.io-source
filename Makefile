.PHONY: server build sync save publish

server:
	hugo server

sync:
	git -C ~/projects/sites/hellupline.github.io pull origin

build: | sync
	hugo --destination ~/projects/sites/hellupline.github.io/ --gc --minify

save: | build
	git -C ~/projects/sites/hellupline.github.io add ~/projects/sites/hellupline.github.io
	git -C ~/projects/sites/hellupline.github.io commit -m 'update site'

publish: | save
	git -C ~/projects/sites/hellupline.github.io push origin

hugo:
	go get github.com/gohugoio/hugo
	go install github.com/gohugoio/hugo
