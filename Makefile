.PHONY: build install

all: build install

build:
	docker build . -t tools:latest

install:
	./install

uninstall:
	rm ~/.tools-aliases
