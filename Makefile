all: build

build: 
	docker build . -t tools:latest

