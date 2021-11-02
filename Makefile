.PHONY: build install uninstall

all: build install

build:
	docker build . --platform linux/$$(uname -m) -t dtk:latest

install:
	./bin/install

uninstall:
	rm ~/.tools-aliases
