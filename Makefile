.PHONY: build install uninstall

all: build install

build:
	docker build . --platform linux/amd64 -f ./docker/c3tk/Dockerfile -t wayneeseguin/c3tk:latest

install: configs c3tk 

c3tk:
	sudo ./bin/c3tk install

uninstall:
	./bin/uninstall

configs:
	mkdir -p ~/.config/c3tk/config && cp config/*.c3tk ~/.config/c3tk/config/

push:
	docker push wayneeseguin/c3tk:latest

publish: build push
