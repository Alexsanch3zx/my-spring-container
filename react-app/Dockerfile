# Build stage
FROM node:18-alpine as build

# Set working directory
WORKDIR /app

# Accept build argument for API URL
ARG REACT_APP_API_URL=http://spring-service:8080
ENV REACT_APP_API_URL=$REACT_APP_API_URL

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy source code
COPY . .

# Build the React app for production
RUN npm run build

# Production stage
FROM nginx:alpine

# Copy the built React app to nginx html directory
COPY --from=build /app/build /usr/share/nginx/html

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]

