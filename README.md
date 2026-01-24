# n8n Robot Framework Docker

Docker images for n8n with Robot Framework and Playwright support.

## Images

| Image | Description |
|-------|-------------|
| `delilovic/n8n_base` | Base image with Node.js and system dependencies |
| `delilovic/n8n` | n8n workflow automation (installed from npm) |
| `delilovic/n8n_robotframework` | n8n with Robot Framework and Playwright |

## Why Debian Bookworm?

These images use **Debian Bookworm** instead of Alpine Linux because Robot Framework Browser (Playwright) requires **glibc**. Alpine uses musl libc, which is incompatible with Playwright's pre-built binaries.

## Build

### GitHub Actions (Multi-platform: AMD64 + ARM64)

1. Go to **Actions** → **Build n8n Robot Framework Images**
2. Click **Run workflow**
3. Enter Node.js version and n8n version
4. Images are pushed to Docker Hub

### Local Build (Host architecture only)

```bash
./docker/images/build-n8n-robotframework.sh <NODE_VERSION> <N8N_VERSION>
```

Example:
```bash
./docker/images/build-n8n-robotframework.sh 22.22.0 2.4.4
```

## Run

```bash
docker run -it --rm --name n8n \
  -p 5678:5678 \
  -v ~/.n8n:/home/node/.n8n \
  delilovic/n8n_robotframework:latest
```

## Requirements

- Docker
- Docker Hub account (for pushing images)
- `DOCKERHUB_TOKEN` secret in GitHub (for Actions)
