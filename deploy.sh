#!/bin/bash

# Full-Stack Kubernetes Deployment Script
# This script builds, pushes, and deploys both Spring Boot and React applications

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Full-Stack Kubernetes Deployment Script${NC}"
echo "=============================================="

# Check if Docker Hub username is provided
if [ -z "$1" ]; then
    echo -e "${RED}❌ Error: Docker Hub username required${NC}"
    echo "Usage: ./deploy.sh <your-dockerhub-username>"
    echo "Example: ./deploy.sh johndoe"
    exit 1
fi

DOCKER_USERNAME=$1
echo -e "${YELLOW}📦 Using Docker Hub username: ${DOCKER_USERNAME}${NC}"

# Check prerequisites
echo -e "${BLUE}🔍 Checking prerequisites...${NC}"

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo -e "${RED}❌ Docker is not running. Please start Docker Desktop.${NC}"
    exit 1
fi

# Check if kubectl is available
if ! command -v kubectl &> /dev/null; then
    echo -e "${RED}❌ kubectl is not installed or not in PATH.${NC}"
    exit 1
fi

# Check if Kubernetes context is available
if ! kubectl cluster-info > /dev/null 2>&1; then
    echo -e "${RED}❌ Kubernetes cluster is not accessible. Please enable Kubernetes in Docker Desktop.${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Prerequisites check passed${NC}"

# Login to Docker Hub
echo -e "${BLUE}🔐 Logging into Docker Hub...${NC}"
if ! docker login; then
    echo -e "${RED}❌ Failed to login to Docker Hub${NC}"
    exit 1
fi

# Build Spring Boot application
echo -e "${BLUE}🏗️  Building Spring Boot application...${NC}"
docker build -t ${DOCKER_USERNAME}/my-spring-app:latest .
echo -e "${GREEN}✅ Spring Boot image built successfully${NC}"

# Build React application
echo -e "${BLUE}🏗️  Building React application...${NC}"
cd react-app
docker build -t ${DOCKER_USERNAME}/react-frontend:1.0.0 .
cd ..
echo -e "${GREEN}✅ React image built successfully${NC}"

# Push images to Docker Hub
echo -e "${BLUE}📤 Pushing images to Docker Hub...${NC}"
docker push ${DOCKER_USERNAME}/my-spring-app:latest
docker push ${DOCKER_USERNAME}/react-frontend:1.0.0
echo -e "${GREEN}✅ Images pushed to Docker Hub successfully${NC}"

# Update Kubernetes manifests
echo -e "${BLUE}📝 Updating Kubernetes manifests...${NC}"
sed -i.bak "s/<your-dockerhub-username>/${DOCKER_USERNAME}/g" k8s/spring-deployment.yaml
sed -i.bak "s/<your-dockerhub-username>/${DOCKER_USERNAME}/g" k8s/react-deployment.yaml
echo -e "${GREEN}✅ Kubernetes manifests updated${NC}"

# Deploy to Kubernetes
echo -e "${BLUE}🚀 Deploying to Kubernetes...${NC}"
kubectl apply -f k8s/spring-deployment.yaml
kubectl apply -f k8s/spring-service.yaml
kubectl apply -f k8s/react-deployment.yaml
kubectl apply -f k8s/react-service.yaml
echo -e "${GREEN}✅ Applications deployed to Kubernetes${NC}"

# Wait for deployments to be ready
echo -e "${BLUE}⏳ Waiting for deployments to be ready...${NC}"
kubectl wait --for=condition=available --timeout=300s deployment/spring-deployment
kubectl wait --for=condition=available --timeout=300s deployment/react-deployment
echo -e "${GREEN}✅ All deployments are ready${NC}"

# Show deployment status
echo -e "${BLUE}📊 Deployment Status:${NC}"
kubectl get all

# Get service information
echo -e "${BLUE}🌐 Service Information:${NC}"
echo "React Frontend: http://localhost:30080"
echo "Spring Boot API: http://spring-service:8080 (internal)"
echo ""
echo -e "${YELLOW}📋 Next Steps:${NC}"
echo "1. Open http://localhost:30080 in your browser"
echo "2. Test the CRUD operations"
echo "3. Take screenshots for assignment submission"
echo ""
echo -e "${GREEN}🎉 Deployment completed successfully!${NC}"

# Cleanup function
cleanup() {
    echo -e "${YELLOW}🧹 Cleaning up...${NC}"
    # Restore original manifests
    mv k8s/spring-deployment.yaml.bak k8s/spring-deployment.yaml 2>/dev/null || true
    mv k8s/react-deployment.yaml.bak k8s/react-deployment.yaml 2>/dev/null || true
}

# Set trap to cleanup on script exit
trap cleanup EXIT
