# Latest version of Golang image: https://hub.docker.com/_/golang?tab=tags
FROM golang:1.20.1-bullseye

# Latest Task version: https://api.github.com/repos/go-task/task/releases/latest
ARG TASK_VERSION=v3.12.0
ARG TASK_SHA256=fafc8621d1b481bcbb1fe2b2ce47940e8d2144c4c4566f0449a3722c2dbb1398

# Latest Task version: https://api.github.com/repos/golangci/golangci-lint/releases/latest
ARG GOLANGCI_LINT_VERSION=v1.45.2
ARG GOLANGCI_LINT_SHA256=15720f9c4c6f9324af695f081dc189adc7751b255759e78d7b2df1d7e9192533

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update \
    && apt-get install --assume-yes --no-install-recommends \
        openssh-client \
        sudo \
        neovim \
        netcat \
        # VSCode Live Share Extension dependencies
        libicu67 \
        libkrb5-3 \
        zlib1g \
        gnome-keyring \
        libsecret-1-0 \
        desktop-file-utils \
        x11-utils \
    && curl -fsSLo /tmp/task_linux_amd64.deb "https://github.com/go-task/task/releases/download/$TASK_VERSION/task_linux_amd64.deb" \
    && echo "$TASK_SHA256 */tmp/task_linux_amd64.deb" | sha256sum -c - \
    && dpkg -i /tmp/task_linux_amd64.deb \
    && curl -fsSLo /tmp/golangci_lint_linux_amd64.deb "https://github.com/golangci/golangci-lint/releases/download/$GOLANGCI_LINT_VERSION/golangci-lint-${GOLANGCI_LINT_VERSION#"v"}-linux-amd64.deb" \
    && echo "$GOLANGCI_LINT_SHA256 */tmp/golangci_lint_linux_amd64.deb" | sha256sum -c - \
    && dpkg -i /tmp/golangci_lint_linux_amd64.deb \
    && apt-get autoremove --assume-yes \
    && apt-get clean --assume-yes \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*

CMD ["/bin/bash"]
