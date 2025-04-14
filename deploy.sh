#!/bin/bash

set -e

echo "🚀 Starting Docker deployment..."

# DockerHub info
DOCKER_USERNAME="${DOCKERHUB_USERNAME}"
DOCKER_TOKEN="${DOCKERHUB_TOKEN}"
IMAGE_NAME="tarun2210/my-image"

echo "🐳 Building Docker image..."
docker build -t $IMAGE_NAME .

echo "🏷️ Tagging Docker image..."
docker tag $IMAGE_NAME $IMAGE_NAME:latest

echo "🔐 Logging into DockerHub..."
echo "$DOCKER_TOKEN" | docker login -u "$DOCKER_USERNAME" --password-stdin

echo "⬆️ Pushing Docker image to DockerHub..."
docker push $IMAGE_NAME
docker push $IMAGE_NAME:latest

echo "✅ Deployment completed!"
