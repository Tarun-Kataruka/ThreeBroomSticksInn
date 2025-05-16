#!/bin/bash

set -e

echo "🚀 Starting Docker deployment..."

DOCKER_USERNAME="${DOCKERHUB_USERNAME}"
DOCKER_TOKEN="${DOCKERHUB_TOKEN}"
IMAGE_NAME="tarun2210/threebroomsticks-inn"

echo "🐳 Building Docker image..."
docker build -t $IMAGE_NAME .

echo "🏷️ Tagging Docker image..."
docker tag $IMAGE_NAME $IMAGE_NAME:latest

echo "🔐 Logging into DockerHub..."
echo "$DOCKER_TOKEN" | docker login -u "$DOCKER_USERNAME" --password-stdin

echo "⬆️ Pushing Docker image to DockerHub..."
docker push $IMAGE_NAME
docker push $IMAGE_NAME:latest

echo "📦 Applying Kubernetes deployment..."
kubectl apply -f k8s/deployment.yaml

echo "✅ Deployment completed!"
