#!/bin/bash

echo "🧹 Cleaning up local Docker resources..."

# 1. Stop and remove any containers using the image
CONTAINERS=$(docker ps -a -q --filter ancestor=stratos-app:local)

if [ -n "$CONTAINERS" ]; then
    echo "🛑 Stopping running containers..."
    docker stop $CONTAINERS
    echo "🗑️  Removing containers..."
    docker rm $CONTAINERS
fi

# 2. Remove the local image
if docker image inspect stratos-app:local >/dev/null 2>&1; then
    echo "🗑️  Removing image stratos-app:local..."
    docker rmi stratos-app:local
fi

echo "✨ Local cleanup complete."