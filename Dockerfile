# syntax=docker/dockerfile:1
FROM vault:latest AS vault
FROM gcr.io/google.com/cloudsdktool/cloud-sdk:latest AS gcsdk
FROM amazon/aws-cli AS awscli
FROM ruby:latest as ruby
FROM ubuntu:latest

COPY --from=vault /bin/vault /bin/vault 
COPY --from=gcsdk /usr/lib/google-cloud-sdk /root/google-cloud-sdk
COPY --from=awscli /usr/local/aws-cli/ /usr/local/aws-cli/
COPY --from=awscli /usr/local/bin/ /usr/local/bin/
COPY --from=ruby /usr/share/mime/application/x-ruby.xml  /usr/share/mime/application/x-ruby.xml
COPY --from=ruby /usr/local/ /usr/local/

RUN apt-get update && ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime && \
	apt-get install -y --no-install-recommends tzdata && \
	dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get install -y --no-install-recommends bash curl wget tar git make less \
	openssh-client procps dnsutils whois netcat tcpdump sipcalc perl python3 tig \
	tmux tree pwgen unzip nmap gpg

ADD ./build /build
ADD ./aliases /aliases

RUN /build

CMD /bin/bash -c "echo -e '\nAdd the following aliases to your shell rc file:\n' && cat /aliases"
