# Use official Node.js image
FROM node:18-alpine

# Set working directory in container
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy remaining source code
COPY . .

# App listens on port 3000
EXPOSE 3000

# Run the app
CMD ["node", "app.js"]