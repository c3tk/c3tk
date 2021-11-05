# Containerized Command Center Tool Kit (c3tk)

This is a busybox style tool kit for being able to leverage many tools on any
workstation without having to install them on the host system in a repeatably
and consistently.

## Prerequsites 

First install [Docker](https://www.docker.com/products/docker-desktop)

## Installation

1. Download the [c3tk repo](https://github.com/starkandwayne/c3tk) 
2. Run `make install`

## How to Use

Installation installs the following commands to `/usr/local/bin`.

Ensure that `/usr/local/bin` is in your path and then use these in your terminal:

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
* terraform
* terragrunt
* tools
* vault

## Notes

`fly` can take a little longer to run depending on network connectivity and 
bandwith to the concourse server. This is because it will run 
`fly -t $target sync` before running the acutal command to ensure that the 
cli version matches the target version. We do this because otherwise the fly
command is programmed to unhelpfully choose to not run.

