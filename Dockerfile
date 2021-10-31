FROM vault:latest AS vault

FROM alpine:latest

RUN apk add curl tar bash git dropbear-ssh git bind-tools whois tcpdump sipcalc \
	make perl python3 

COPY --from=vault /bin/vault /bin/vault 

ADD ./build /build
ADD ./aliases /aliases

RUN /build

CMD /bin/bash -c "echo -e '\nAdd the following aliases to your shell rc file:\n' && cat /aliases"



