# Containerized Command Center Tool Kit (c3tk)

This is a busybox style tool kit for being able to leverage many tools on any
workstation without having to install them on the host system in a repeatably
and consistently.

## Prerequsites 

First install a container runtime:
* [Docker](https://www.docker.com/products/docker-desktop)
* (TODO) [Podman](https://podman.io/getting-started/)

## Installation Via GitHub

Security Note: Please inspect the script before you run it so you understand 
what is happening! Also feel free to download and install as separate steps. :)
```
curl -o - https://raw.githubusercontent.com/c3tk/c3tk/main/bin/c3tk | sudo bash -
```
Follow the output of the instructions emitted from the install such as adding
to your `PATH:
```
grep -q c3tk ~/.profile || echo '[[ -x /opt/c3tk/bin/c3tk ]] && export PATH="$(/opt/c3tk/bin/c3tk paths):$PATH"' >> ~/.profile
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
c3tk add aws image=amazon/aws-cli
```

Alternatively we can install sets of commands via `.c3tk` files. First place the
files into your `~/.c3tk/config` directory such as
```
ls ~/.c3tk/config
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
## Workspaces

Workspaces are intended for scenarios where we wish to have multiple commands
available for use on a single container that we work with, as well as when we 
want to use long running container sessions. Workspaces can be listed, paused,
and unpaused.

For example,

```
c3tk workspace create genesis
```
Will create a `genesis` workspace with the current working directory mounted at
`/w` on the container. Then we can also attach to the workspace container like so:
```
c3tk workspace attach genesis
```
For convenience and efficiency most commands have shorthands, in this case we could
have simply type `c3tk w c genesis` and `c3tk w a genesis` instead.

See the output of `c3tk w` for more options.

## Development Installation Via Repository

1. Download the [c3tk repo](https://github.com/wayneeseguin/c3tk) 
2. Run `make `

