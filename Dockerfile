FROM vault:latest AS vault
FROM gcr.io/google.com/cloudsdktool/cloud-sdk:latest AS gcsdk
FROM alpine:latest

COPY --from=vault /bin/vault /bin/vault 
COPY --from=gcsdk /usr/lib/google-cloud-sdk /root/google-cloud-sdk

RUN apk add --no-cache curl wget tar bash git dropbear-ssh git bind-tools whois \
	tcpdump sipcalc make perl python3 ruby aws-cli

ADD ./build /build
ADD ./aliases /aliases

RUN /build

CMD /bin/bash -c "echo -e '\nAdd the following aliases to your shell rc file:\n' && cat /aliases"



