ARG BASE_IMAGE=golang
ARG BASE_VERSION=1.25.4-alpine3.22

FROM ${BASE_IMAGE}:${BASE_VERSION}

ARG LAZYDOCKER_VERSION=v0.24.2

# Install dependencies
RUN apk add --no-cache \
    tzdata \
    ttyd && \
    rm -rf /var/cache/apk/*

# Install lazydocker
RUN go install github.com/jesseduffield/lazydocker@${LAZYDOCKER_VERSION} && \
    rm -rf /root/.cache /go/pkg/mod

# Expose ttyd port
EXPOSE 7682

# Create a volume for lazydocker config
VOLUME [ "/.config/jesseduffield/lazydocker" ]

# Run ttyd with lazydocker
CMD ["ttyd", "-p", "7682", "-W", "lazydocker"]

# OCI Image Labels - https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.title="LazyDocker Web UI"
LABEL org.opencontainers.image.description="Web-based Docker management UI using lazydocker and ttyd"
LABEL org.opencontainers.image.authors="Jeppe Stærk"
LABEL org.opencontainers.image.url="https://github.com/jeppestaerk/lazydocker-webui"
LABEL org.opencontainers.image.source="https://github.com/jeppestaerk/lazydocker-webui"
LABEL org.opencontainers.image.documentation="https://github.com/jeppestaerk/lazydocker-webui/blob/main/README.md"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.vendor="Jeppe Stærk"
LABEL org.opencontainers.image.base.name="docker.io/library/golang:${BASE_VERSION}"
LABEL maintainer="Jeppe Stærk"
