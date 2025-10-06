# Assignment Summary: Full-Stack Microservices on Kubernetes

## Challenges Faced and Solutions

### Challenge 1: React Frontend to Spring Boot Communication
**Problem**: The React application was failing to create items with a "Failed to create item" error. The frontend could not communicate with the Spring Boot backend.

**Root Cause**: Initially, I configured the React app to connect to the Spring service using the internal Kubernetes service name (`http://spring-service:8080`). However, this approach failed because:
1. React applications run in the browser, not within the Kubernetes cluster
2. The browser cannot resolve Kubernetes internal DNS names
3. The browser cannot access pod IPs directly

**Solution**: I reconfigured the architecture to use NodePort services:
- Changed the Spring service from ClusterIP to NodePort (port 30081)
- Rebuilt the React application to connect to `http://localhost:30081`
- This allows the browser to access the Spring Boot API through the host's localhost

### Challenge 2: Spring Boot Network Binding
**Problem**: Even after fixing the service configuration, the Spring Boot application was only binding to localhost within the container, preventing external connections.

**Solution**: Added `server.address=0.0.0.0` to `application.properties` to make Spring Boot listen on all network interfaces, allowing it to accept connections from outside the container.

### Challenge 3: React Environment Variables at Build Time
**Problem**: React environment variables need to be embedded at build time, not runtime. Setting `REACT_APP_API_URL` as a Kubernetes environment variable didn't work.

**Solution**: Modified the React Dockerfile to accept `REACT_APP_API_URL` as a build argument (`ARG`) and set it as an environment variable during the build stage, ensuring the correct API URL is compiled into the JavaScript bundle.

## How AI Tools Were Used

### 1. Problem Diagnosis
- Used AI to analyze error messages and logs to identify the root cause of connectivity issues
- AI helped trace the flow of HTTP requests from the browser through Kubernetes services to the backend pods

### 2. Architecture Decisions
- AI provided guidance on Kubernetes networking concepts (ClusterIP vs NodePort)
- Explained the difference between in-cluster networking and browser-based access patterns
- Helped understand that React apps in the browser need publicly accessible endpoints

### 3. Configuration Solutions
- AI suggested specific configuration changes (NodePort, build arguments, server.address)
- Provided step-by-step commands for rebuilding containers and redeploying to Kubernetes
- Helped create comprehensive documentation and troubleshooting guides

### 4. Best Practices
- AI recommended proper CORS configuration for cross-origin requests
- Suggested resource limits and health checks for production readiness
- Guided the creation of automated deployment scripts for easier setup

### 5. Debugging Process
- AI helped execute systematic troubleshooting: checking pod logs, testing connectivity, verifying service endpoints
- Provided commands to test API endpoints and verify configuration
- Assisted in understanding Docker build contexts and Kubernetes deployment workflows

## Key Learnings

1. **Kubernetes Networking**: Understanding the difference between in-cluster service discovery and external access patterns
2. **React Build Process**: Environment variables must be set at build time, not runtime
3. **Service Types**: When to use ClusterIP (internal) vs NodePort (external access)
4. **Container Networking**: Importance of binding to 0.0.0.0 instead of localhost in containerized applications

## Final Architecture

- **React Frontend**: Running in browser, accessible at http://localhost:30080
- **Spring Boot Backend**: NodePort service accessible at http://localhost:30081
- **Communication Flow**: Browser → http://localhost:30081 → Kubernetes NodePort → Spring Boot Pods
- **Deployment**: 2 replicas each for high availability (4 pods total)

## Technologies Used

- **Frontend**: React 19, NGINX Alpine
- **Backend**: Spring Boot 3.5.6, Java 24
- **Containerization**: Docker, multi-stage builds
- **Orchestration**: Kubernetes (Docker Desktop)
- **Tools**: kubectl, Docker CLI, Gradle, npm

