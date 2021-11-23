.PHONY: build install uninstall

all: build install

build:
	docker build . --platform linux/amd64 -f ./images/c3tk/Dockerfile -t wayneeseguin/c3tk:latest

install: 
	mkdir -p ~/.c3tk/{config,bin,lib}
	cp config/*.c3tk ~/.c3tk/config/
	sudo mkdir -p /opt/c3tk/{config,bin,lib}
	sudo cp lib/*.bash /opt/c3tk/lib/
	sudo cp bin/c3tk /opt/c3tk/bin/
	sudo cp bin/c3tk /usr/local/bin/

uninstall:
	sudo rm -rf /opt/c3tk /usr/local/bin/c3tk
	rm -rf ~/.c3tk
	echo "Don't forget to remove the PATH entry in your profiles."

push:
	docker push wayneeseguin/c3tk:latest

publish: build push
