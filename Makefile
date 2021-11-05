.PHONY: build install uninstall

all: build install

build:
	docker build . --platform linux/amd64 -t starkandwayne/c3tk:latest

install:
	./bin/c3tk install

uninstall:
	./bin/uninstall

push:
	docker push starkandwayne/c3tk:latest

publish: build push
