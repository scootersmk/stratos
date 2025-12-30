#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "🏗️  Building Docker image..."
docker build -t stratos-app:local app/

echo "🚀 Running container on http://localhost:8080"
docker run --rm -it \
  -p 8080:8080 \
  -e PORT=8080 \
  -e K_SERVICE=local-dev \
  -e K_REVISION=v-local \
  stratos-app:local