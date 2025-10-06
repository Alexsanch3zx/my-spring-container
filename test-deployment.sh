#!/bin/bash

# Test Deployment Script
# This script tests the deployed application

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🧪 Testing Full-Stack Deployment${NC}"
echo "=================================="

# Check if kubectl is available
if ! command -v kubectl &> /dev/null; then
    echo -e "${RED}❌ kubectl is not installed or not in PATH.${NC}"
    exit 1
fi

# Check if Kubernetes context is available
if ! kubectl cluster-info > /dev/null 2>&1; then
    echo -e "${RED}❌ Kubernetes cluster is not accessible.${NC}"
    exit 1
fi

echo -e "${BLUE}📊 Checking deployment status...${NC}"
kubectl get all

echo -e "${BLUE}⏳ Waiting for all pods to be ready...${NC}"
kubectl wait --for=condition=ready pod -l app=spring-app --timeout=300s
kubectl wait --for=condition=ready pod -l app=react-app --timeout=300s

echo -e "${GREEN}✅ All pods are ready${NC}"

# Test Spring Boot API
echo -e "${BLUE}🔍 Testing Spring Boot API...${NC}"
SPRING_POD=$(kubectl get pods -l app=spring-app -o jsonpath='{.items[0].metadata.name}')
echo "Using Spring pod: $SPRING_POD"

# Test API endpoints
echo "Testing GET /api/items..."
kubectl exec $SPRING_POD -- curl -s http://localhost:8080/api/items || echo -e "${YELLOW}⚠️  API test failed${NC}"

# Test React frontend
echo -e "${BLUE}🔍 Testing React frontend...${NC}"
REACT_POD=$(kubectl get pods -l app=react-app -o jsonpath='{.items[0].metadata.name}')
echo "Using React pod: $REACT_POD"

# Test React health endpoint
echo "Testing React health endpoint..."
kubectl exec $REACT_POD -- curl -s http://localhost:80/health || echo -e "${YELLOW}⚠️  React health test failed${NC}"

# Get service information
echo -e "${BLUE}🌐 Service Information:${NC}"
echo "React Frontend: http://localhost:30080"
echo "Spring Boot API: http://spring-service:8080 (internal)"

# Test service connectivity
echo -e "${BLUE}🔗 Testing service connectivity...${NC}"
kubectl exec $REACT_POD -- curl -s http://spring-service:8080/api/items || echo -e "${YELLOW}⚠️  Service connectivity test failed${NC}"

echo -e "${GREEN}🎉 Testing completed!${NC}"
echo ""
echo -e "${YELLOW}📋 Manual Testing Steps:${NC}"
echo "1. Open http://localhost:30080 in your browser"
echo "2. Test creating a new item"
echo "3. Test editing an existing item"
echo "4. Test deleting an item"
echo "5. Verify data persists after refresh"
echo ""
echo -e "${BLUE}📸 Don't forget to take screenshots for assignment submission!${NC}"
