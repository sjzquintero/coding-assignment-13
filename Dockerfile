# Use a base Node.js image to build the application
FROM node:14 AS build

# Set the working directory
WORKDIR /app

# Copy the project files to the container
COPY . .

# Install the dependencies and build the application
RUN npm install
RUN npm run build

# Use a base Nginx image to serve the application
FROM nginx:stable-alpine

#Copy the built files from the build stage to the Nginx container
COPY --from=build /app/build /usr/share/nginx/html

# Set the working directory
WORKDIR /usr/share/nginx/html

# Expose port 8018 to access the application
EXPOSE 8018

# Command to run Nginx
CMD ["nginx", "-g", "daemon off;"]