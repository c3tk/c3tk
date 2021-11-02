# Containerized Command Center Tool Kit (c3tk)

This is a busybox style tool kit for being able to leverage many tools on any
workstation without having to install them on the host system in a repeatably
and consistently.

## Prerequsites 

First install [Docker](https://www.docker.com/products/docker-desktop)

## How to use the tools

Download this repository and run `make`.

Now when you open a new shell you can directly use the latest cloud tools:

* c3tk
* aws
* bosh
* cc-me
* cf
* credhub
* fly
* gcloud
* genesis
* gsutil
* jq
* k9s
* kubectl
* run-help
* safe
* spruce
* tools
* vault

# Manual Installation

Pull the image of this and run `docker run --rm tools:latest`. 

Follow the instructions that it prints.

