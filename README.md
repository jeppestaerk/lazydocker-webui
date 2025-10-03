# LazyDocker Web UI

A Docker containerized deployment of [lazydocker](https://github.com/jesseduffield/lazydocker) with web-based terminal access via [ttyd](https://github.com/tsl0922/ttyd).

## Features

- 🌐 Browser-based access to lazydocker terminal UI
- 🐳 Multi-architecture support (amd64, arm64)
- 🔄 Automated dependency updates via Renovate
- 📦 Published to GitHub Container Registry
- 🔒 Includes SBOM and provenance attestations

## Quick Start

### Using Docker Compose

```bash
docker compose up -d
```

Access lazydocker at `http://localhost:7682`

### Using Pre-built Image

```bash
docker run -d \
  --name lazydocker-webui \
  -p 7682:7682 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v lazydocker-config:/.config/jesseduffield/lazydocker \
  ghcr.io/jeppestaerk/lazydocker-webui:latest
```

## Configuration

### Environment Variables

- `TZ` - Timezone (default: `Europe/Copenhagen`)

### Volumes

- `/var/run/docker.sock` - Required for Docker host access
- `/.config/jesseduffield/lazydocker` - Persists lazydocker configuration

### Ports

- `7682` - ttyd web interface

## Development

### Build Locally

```bash
docker build -t lazydocker-webui .
```

### View Logs

```bash
docker compose logs -f
```

### Stop Service

```bash
docker compose down
```

## Dependencies

Dependencies are automatically updated via Renovate:

- **Go Alpine Base Image**: Tracked from Docker Hub `golang` repository
- **Lazydocker**: Tracked from GitHub releases

Updates run weekly on Mondays before 4am UTC and auto-merge when CI passes.

## CI/CD

GitHub Actions automatically builds and publishes multi-architecture images to GitHub Container Registry on every push to `main`.

## License

This project is a containerized wrapper. See the upstream projects for their licenses:
- [lazydocker](https://github.com/jesseduffield/lazydocker)
- [ttyd](https://github.com/tsl0922/ttyd)
