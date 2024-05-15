# Stage 1: Build the application
FROM node:14 AS builder

WORKDIR /app
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install
COPY . .

# Build the application
RUN npm run build

# Stage 2: Create the production image
FROM nginx

# Copy build files from the builder stage to nginx
COPY --from=builder /app/build /usr/share/nginx/html

# Expose port
EXPOSE 80

# Start nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
