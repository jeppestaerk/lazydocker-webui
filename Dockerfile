ARG BASE_IMAGE=golang
ARG BASE_VERSION=1.25.1-alpine3.22

FROM ${BASE_IMAGE}:${BASE_VERSION}

ARG LAZYDOCKER_VERSION=v0.24.1

# Install dependencies
RUN apk add --no-cache \
    tzdata \
    ttyd 

# Install lazydocker
RUN go install github.com/jesseduffield/lazydocker@${LAZYDOCKER_VERSION}

# Expose ttyd port
EXPOSE 7682

# Create a volume for lazydocker config
VOLUME [ "/.config/jesseduffield/lazydocker" ]

# Run ttyd with lazydocker
CMD ["ttyd", "-p", "7682", "-W", "lazydocker"]
