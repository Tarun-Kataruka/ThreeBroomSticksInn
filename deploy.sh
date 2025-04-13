#!/bin/bash

# Exit the script on any error
set -e

# Print some messages for debugging
echo "Starting deployment..."

# Step 1: Pull the latest changes from the repository
git pull origin master

# Step 2: Install dependencies (if needed)
# This step is only required if you're using a package manager like npm
# npm install

# Step 3: Build the app (if necessary)
# This depends on your project type, e.g., for React:
# npm run build

# For a simple HTML project, you can skip the build step.

# Step 4: Deploy to your hosting environment (example: deploy to a server using SCP)
# Example: Deploy to a remote server via SCP (replace with your server credentials)
# scp -r ./build/* user@your-server:/path/to/your/project

# If you're using a platform like Netlify, Vercel, or others, the deployment may be automatic.

echo "Deployment completed successfully!"
