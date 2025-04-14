#!/bin/bash

# Exit the script on any error
set -e

# Print some messages for debugging
echo "🚀 Starting Docker deployment..."

# Step 1: Pull latest changes from the master branch
echo "🔄 Pulling latest changes from GitHub..."
git pull origin master

# Step 2: Define DockerHub credentials
DOCKER_USERNAME="tarun2210"
IMAGE_NAME="threebroomsticks-inn"

# Step 3: Build the Docker image
echo "🐳 Building Docker image..."
docker build -t $IMAGE_NAME .

# Step 4: Tag the Docker image
echo "🏷️ Tagging Docker image..."
docker tag $IMAGE_NAME $DOCKER_USERNAME/$IMAGE_NAME

# Step 5: Login to DockerHub securely using password from environment variable
echo "🔐 Logging into DockerHub..."
echo "$DOCKER_PASSWORD" | docker login --username $DOCKER_USERNAME --password-stdin

# Step 6: Push Docker image to DockerHub
echo "⬆️ Pushing Docker image to DockerHub..."
docker push $DOCKER_USERNAME/$IMAGE_NAME

echo "✅ Deployment completed successfully!"
