FROM vault:latest AS vault

FROM alpine:latest

RUN apk add curl tar bash perl git python3

# Install the `bosh` CLI
RUN curl -L https://github.com/cloudfoundry/bosh-cli/releases/download/v6.4.7/bosh-cli-6.4.7-linux-amd64 -o /bin/bosh && chmod 0755 /bin/bosh && bosh -v

# Install the `cf` CLI
RUN curl -L "https://packages.cloudfoundry.org/stable?release=linux64-binary&version=v7&source=github" | tar -zx && mv cf7 /bin/ && ln -s /bin/cf7 /bin/cf && cf -v
#RUN mkdir -p /usr/share/bash-completion/completions/ && curl -o /usr/share/bash-completion/completions/cf7 https://raw.githubusercontent.com/cloudfoundry/cli-ci/master/ci/installers/completion/cf7

# Install the `jq` CLI
RUN curl -L https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 -o /bin/jq && chmod 0766 /bin/jq && jq -V

# Install the `safe` CLI
RUN curl -L https://github.com/starkandwayne/safe/releases/download/v1.6.1/safe-linux-amd64 -o /bin/safe && chmod 0755 /bin/safe && safe -v

# Install the `spruce` CLI
RUN curl -L https://github.com/geofffranks/spruce/releases/download/v1.29.0/spruce-linux-amd64 -o /bin/spruce && chmod 0755 /bin/spruce && spruce -v

# Install the `vault` CLI
COPY --from=vault /bin/vault /bin/vault 
RUN vault -v

# Install the `credhub` CLI
RUN curl -L https://github.com/cloudfoundry/credhub-cli/releases/download/2.9.1/credhub-linux-2.9.1.tgz | tar -zx && mv credhub /bin/credhub && credhub --version

# Install the `genesis CLi`
RUN curl -L https://github.com/genesis-community/genesis/releases/download/v2.8.2/genesis -o /bin/genesis && chmod 0755 /bin/genesis && genesis -v

CMD ["/bin/bash"]
