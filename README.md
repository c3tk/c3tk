# Containerized Command Center Tool Kit (c3tk)

This is a busybox style tool kit for being able to leverage many tools on any
workstation without having to install them on the host system in a repeatably
and consistently.

## Prerequsites 

First install [Docker](https://www.docker.com/products/docker-desktop)

## Installation Via GitHub

```
curl -sL https://raw.githubusercontent.com/wayneeseguin/c3tk/main/bin/c3tk -o c3tk &&  
  chmod 0755 ./c3tk && sudo ./c3tk install
```
Follow the output of the instructions emitted from the install such as adding
to your `PATH:
```
grep -q c3tk ~/.profile || echo 'export PATH="$(c3tk paths):$PATH"' >> ~/.profile
```
Then open a new shell and start adding the commands you are interested in.

## Configuration

Individual commands may be added from the command line as follows,
```
c3tk add <name> <image>
```
Run `c3tk add` to see a full description of the help output.

So for example to add the aws cli we run:
```
c3tk add aws image=amazon/aws-cli configs=.aws
```

Alternatively we can install sets of commands via `.c3tk` files. First place the
files into your `~/.config/c3tk/config` directory such as
```
ls ~/.config/c3tk/config
clouds.c3tk
hashicorp.c3tk
k8s.c3tk
```
Then run `c3tk configure` and `c3tk` will install the commands referenced in these
files.

This will install links for the commands in the `INSTALL_PATH`, which defaults
to `/usr/local/bin/c3tk/bin`.

Ensure that `/usr/local/bin/c3tk/bin` is in your path and then use the commands
in your terminal!

NOTE: You can override the installation directory by exporting the environment
variable `INSTALL_PATH` like so:
```
export INSTALL_PATH="/usr/local/bin" ./

```

## Development Installation Via Repository

1. Download the [c3tk repo](https://github.com/wayneeseguin/c3tk) 
2. Run `make `

