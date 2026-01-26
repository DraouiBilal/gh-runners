FROM ubuntu:22.04

RUN useradd -m -s /bin/bash runner \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    bash curl wget perl ca-certificates libicu70 podman podman-docker uidmap slirp4netns fuse-overlayfs  \
    && rm -rf /var/lib/apt/lists/* \
    && update-ca-certificates

RUN wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 \
    && chmod a+x /usr/local/bin/yq \
    && yq --version


USER runner

RUN cd && mkdir -p actions-runner/workspace && cd actions-runner

WORKDIR /home/runner/actions-runner

RUN curl -o actions-runner-linux-x64-2.331.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.331.0/actions-runner-linux-x64-2.331.0.tar.gz \
    && echo "5fcc01bd546ba5c3f1291c2803658ebd3cedb3836489eda3be357d41bfcf28a7  actions-runner-linux-x64-2.331.0.tar.gz" | shasum -a 256 -c \
    && tar xzf ./actions-runner-linux-x64-2.331.0.tar.gz

USER root

RUN cd /home/runner/actions-runner && ./bin/installdependencies.sh

USER runner

COPY ./entrypoint.sh /home/runner/actions-runner/entrypoint.sh


ENTRYPOINT ["/home/runner/actions-runner/entrypoint.sh"]
