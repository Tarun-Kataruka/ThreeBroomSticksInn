# Step 1: Use nginx as the base image
FROM nginx:alpine

# Step 2: Remove the default nginx web files
RUN rm -rf /usr/share/nginx/html/*

# Step 3: Copy your project files into nginx's public folder
COPY . /usr/share/nginx/html

# Step 4: Expose port 80 to the web
EXPOSE 80

# Step 5: Start nginx when the container runs
CMD ["nginx", "-g", "daemon off;"]
