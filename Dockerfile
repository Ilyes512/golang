# Latest version of Golang image: https://hub.docker.com/_/golang?tab=tags
FROM golang:1.18.1-bullseye

RUN apt-get update \
    && apt-get install --assume-yes --no-install-recommends \
        openssh-client \
        sudo \
        # VSCode Live Share Extension dependencies
        libicu67 \
        libkrb5-3 \
        zlib1g \
        gnome-keyring \
        libsecret-1-0 \
        desktop-file-utils \
        x11-utils \
    && apt-get autoremove --assume-yes \
    && apt-get clean --assume-yes \
    && rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
