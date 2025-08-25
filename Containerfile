FROM ubuntu:22.04

RUN useradd -m -s /bin/bash runner \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    bash curl perl ca-certificates libicu70 podman podman-docker uidmap slirp4netns fuse-overlayfs \
    && rm -rf /var/lib/apt/lists/* \
    && update-ca-certificates

USER runner

RUN cd && mkdir -p actions-runner && cd actions-runner && mkdir -p _work

WORKDIR /home/runner/actions-runner

RUN curl -k -o actions-runner-linux-x64-2.328.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.328.0/actions-runner-linux-x64-2.328.0.tar.gz \
    && echo "01066fad3a2893e63e6ca880ae3a1fad5bf9329d60e77ee15f2b97c148c3cd4e  actions-runner-linux-x64-2.328.0.tar.gz" | shasum -a 256 -c \
    && tar xzf ./actions-runner-linux-x64-2.328.0.tar.gz

USER root

RUN cd /home/runner/actions-runner && ./bin/installdependencies.sh

USER runner

COPY ./scripts/entrypoint.sh /home/runner/actions-runner/entrypoint.sh

ENTRYPOINT ["/home/runner/actions-runner/entrypoint.sh"]
