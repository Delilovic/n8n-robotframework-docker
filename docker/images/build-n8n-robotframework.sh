#!/bin/bash
set -e

# Check required arguments
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <NODE_VERSION> <N8N_VERSION>"
    echo "Example: $0 22.22.0 1.121.0"
    exit 1
fi

NODE_VERSION=$1
N8N_VERSION=$2

echo "Building with NODE_VERSION=${NODE_VERSION} and N8N_VERSION=${N8N_VERSION}"
echo ""

# Build n8n-base
echo "=== Building n8n_base ==="
docker build --no-cache --progress=plain \
    --build-arg NODE_VERSION=${NODE_VERSION} \
    -f ./docker/images/n8n-base/Dockerfile \
    -t delilovic/n8n_base:${NODE_VERSION}-bookworm-slim \
    .

# Build n8n
echo ""
echo "=== Building n8n ==="
docker build --no-cache --progress=plain \
    --build-arg NODE_VERSION=${NODE_VERSION} \
    --build-arg N8N_VERSION=${N8N_VERSION} \
    -f ./docker/images/n8n/Dockerfile \
    -t delilovic/n8n:${N8N_VERSION}-bookworm-slim \
    -t delilovic/n8n:latest \
    .

# Build n8n-robotframework
echo ""
echo "=== Building n8n-robotframework ==="
docker build --no-cache --progress=plain \
    --build-arg N8N_VERSION=${N8N_VERSION} \
    -f ./docker/images/n8n-robotframework/Dockerfile \
    -t delilovic/n8n_robotframework:${N8N_VERSION}-bookworm-slim \
    -t delilovic/n8n_robotframework:latest \
    .

echo ""
echo "=== All images built successfully ==="
echo "  - delilovic/n8n_base:${NODE_VERSION}-bookworm-slim"
echo "  - delilovic/n8n:${N8N_VERSION}-bookworm-slim (also tagged as latest)"
echo "  - delilovic/n8n_robotframework:${N8N_VERSION}-bookworm-slim (also tagged as latest)"
