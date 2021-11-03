# syntax=docker/dockerfile:1

FROM ubuntu:latest

RUN apt-get update \
	&& ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime \
	&& apt-get install -y --no-install-recommends \
	libssl-dev bash curl ca-certificates wget make tar git make less \
	openssh-client procps dnsutils whois netcat tcpdump sipcalc perl tig \
	tmux tree pwgen unzip nmap gpg tzdata xz-utils python3 python3-pip \
	&& pip3 install xq \
	&& dpkg-reconfigure --frontend noninteractive tzdata \
  && echo hosts: files dns > /etc/nsswitch.conf

WORKDIR /root

ADD ./bin/build /root/build
RUN /root/build

ARG NIX_VERSION=2.3.15

ONBUILD ENV \
    ENV=/etc/profile \
    USER=root \
    PATH=/nix/var/nix/profiles/default/bin:/nix/var/nix/profiles/default/sbin:/bin:/sbin:/usr/bin:/usr/sbin \
    GIT_SSL_CAINFO=/etc/ssl/certs/ca-certificates.crt \
    NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt

ENV \
    ENV=/etc/profile \
    USER=root \
    PATH=/nix/var/nix/profiles/default/bin:/nix/var/nix/profiles/default/sbin:/bin:/sbin:/usr/bin:/usr/sbin \
    GIT_SSL_CAINFO=/etc/ssl/certs/ca-certificates.crt \
    NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt \
    NIX_PATH=/nix/var/nix/profiles/per-user/root/channels

ADD bin/nix-install /root/nix-install

RUN /root/nix-install

ADD ./bin/fly-wrapper /bin/fly

CMD /bin/bash

