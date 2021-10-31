all: build aliases

build: 
	docker build . -t tools:latest

aliases:
	docker run --rm tools:latest
