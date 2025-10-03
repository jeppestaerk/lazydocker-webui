# LazyDocker Web UI

A Docker containerized deployment of [lazydocker](https://github.com/jesseduffield/lazydocker) with web-based terminal access via [ttyd](https://github.com/tsl0922/ttyd).

## Features

- 🌐 Browser-based access to lazydocker terminal UI
- 🐳 Multi-architecture support (amd64, arm64)
- 🔄 Automated dependency updates via Renovate
- 📦 Published to GitHub Container Registry
- 🔒 Includes SBOM and provenance attestations

## ⚠️ Security Warning

This container requires access to the Docker socket (`/var/run/docker.sock`) and provides **unauthenticated access** to the Docker daemon through a web interface.

**Security considerations:**
- Anyone with access to the web interface (port 7682) can manage all Docker resources on the host
- This grants **root-equivalent access** to the host system
- **Do not expose this port to the internet** without proper authentication/VPN
- Only use on trusted networks or with additional security measures (e.g., reverse proxy with authentication)

**Recommended security measures:**
- Use a reverse proxy (nginx, Traefik, Caddy) with authentication
- Bind to localhost only: `-p 127.0.0.1:7682:7682`
- Use a VPN or SSH tunnel for remote access
- Consider Docker socket proxy solutions for additional isolation

## Quick Start

### Using Pre-built Image from GitHub Container Registry

**With Docker Run:**
```bash
docker run -d \
  --name lazydocker-webui \
  -p 7682:7682 \
  -e TZ=Europe/Copenhagen \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v lazydocker-config:/.config/jesseduffield/lazydocker \
  --restart unless-stopped \
  ghcr.io/jeppestaerk/lazydocker-webui:latest
```

**With Docker Compose:**
```yaml
services:
  lazydocker-webui:
    image: ghcr.io/jeppestaerk/lazydocker-webui:latest
    container_name: lazydocker-webui
    ports:
      - "7682:7682"
    environment:
      - TZ=${TZ:-Europe/Copenhagen}
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - lazydocker-config:/.config/jesseduffield/lazydocker
    restart: unless-stopped

volumes:
  lazydocker-config:
    driver: local
```

Then run:
```bash
docker compose up -d
```

Access lazydocker at `http://localhost:7682`

### Building Locally

Clone the repository:
```bash
git clone git@github.com:jeppestaerk/lazydocker-webui.git
cd lazydocker-webui
```

**With Docker Compose:**

The repository includes a `docker-compose.yaml` that builds from source:
```bash
docker compose up -d
```

**With Docker Run:**
```bash
# Build the image
docker build -t lazydocker-webui .

# Run the container
docker run -d \
  --name lazydocker-webui \
  -p 7682:7682 \
  -e TZ=Europe/Copenhagen \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v lazydocker-config:/.config/jesseduffield/lazydocker \
  --restart unless-stopped \
  lazydocker-webui
```

Access lazydocker at `http://localhost:7682`

## Configuration

### Environment Variables

- `TZ` - Timezone (default: `Europe/Copenhagen`)

### Volumes

- `/var/run/docker.sock` - Required for Docker host access
- `/.config/jesseduffield/lazydocker` - Persists lazydocker configuration

### Ports

- `7682` - ttyd web interface

## Development

### Stop Service

```bash
docker compose up -d
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
