# Production Dockerfile
# Builder phase
FROM node:16-alpine as builder

WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
# build js files
RUN npm run build 

# Runner phase
FROM nginx

# Copy from other phase
COPY --from=builder /app/build /usr/share/nginx/html

# Default command will start nginx and serve website