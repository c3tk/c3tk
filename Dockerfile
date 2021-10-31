FROM vault:latest AS vault

FROM alpine:latest

RUN apk add curl tar bash perl git python3

COPY --from=vault /bin/vault /bin/vault 

ADD ./install /install
ADD ./aliases /aliases

RUN /install

CMD /bin/bash -c "echo -e '\nAdd the following aliases to your shell rc file:\n' && cat /aliases"



