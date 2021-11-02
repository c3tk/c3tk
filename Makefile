.PHONY: build install uninstall

all: build install

build:
	docker build . --platform linux/$$(uname -m) -t starkandwayne/c3tk:latest

install:
	./bin/install

uninstall:
	./bin/uninstall
