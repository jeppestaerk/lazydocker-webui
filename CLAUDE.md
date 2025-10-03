# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This repository provides a Docker containerized deployment of [lazydocker](https://github.com/jesseduffield/lazydocker), a terminal UI for managing Docker containers, images, volumes, and networks. The application is exposed via a web interface using `ttyd`.

## Architecture

- **Dockerfile**: Build that installs lazydocker from Go source and exposes it via ttyd on port 7682
- **docker-compose.yaml**: Orchestration file that mounts the Docker socket and persists lazydocker configuration
- **renovate.json**: Automated dependency updates for golang alpine base image and lazydocker versions using regex managers
- **.github/workflows/docker-publish.yml**: CI/CD pipeline that builds multi-arch images and pushes to GitHub Container Registry

## Key Components

### Docker Socket Mounting
The container requires access to `/var/run/docker.sock` to manage Docker resources on the host system. This is configured in docker-compose.yaml:12-13.

### Web Terminal Access
`ttyd` provides browser-based terminal access to lazydocker on port 7682. This allows remote access to the Docker management interface.

### Configuration Persistence
Lazydocker configuration is stored in a named volume `lazydocker-config` mapped to `/.config/jesseduffield/lazydocker`.

### Automated Dependency Management
Renovate automatically creates PRs for dependency updates and auto-merges them when CI passes. Updates run weekly on Mondays before 4am UTC.

### Multi-Architecture Support
GitHub Actions builds images for both `linux/amd64` and `linux/arm64` platforms, pushed to `ghcr.io`.

## Common Commands

### Build and Run
```bash
# Build the image
docker compose build

# Start the service
docker compose up -d

# View logs
docker compose logs -f

# Stop the service
docker compose down
```

### Access the Application
Once running, access lazydocker via browser at `http://localhost:7682`

### Update Dependencies
Dependencies are managed via Renovate. Version arguments are defined at the top of the Dockerfile:
- `BASE_VERSION` (Dockerfile:2) - Tracks `golang:X.XX.X-alpineX.XX` from Docker Hub
- `LAZYDOCKER_VERSION` (Dockerfile:6) - Tracks releases from jesseduffield/lazydocker GitHub repo

To manually update, modify these ARG values and rebuild.

### GitHub Container Registry
Images are automatically built and pushed to `ghcr.io/jeppestaerk/lazydocker-webui` on every push to main. Pull requests trigger builds but don't push images.
