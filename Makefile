.PHONY: build install uninstall

all: build install

build:
	docker build . --platform linux/$$(uname -m) -t starkandwayne/c3tk:latest

install:
	./bin/install

uninstall:
	./bin/uninstall

push:
	docker push starkandwayne/c3tk:latest

publish: build push
