# Use the official Node.js 20 slim image to keep the footprint small
FROM node:20-slim

# Create and change to the app directory inside the container
WORKDIR /usr/src/app

# Copy application dependency manifests to the container image
COPY package*.json ./

# Install production dependencies (skips devDependencies)
RUN npm install --only=production

# Copy local code to the container image
COPY . .

# Run the web service on container startup
CMD [ "npm", "start" ]
