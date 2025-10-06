#!/bin/bash

# Kubernetes Cleanup Script
# This script removes all deployed resources

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🧹 Kubernetes Cleanup Script${NC}"
echo "=============================="

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

echo -e "${YELLOW}⚠️  This will remove all deployed resources.${NC}"
read -p "Are you sure you want to continue? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${BLUE}Operation cancelled.${NC}"
    exit 0
fi

# Remove all resources
echo -e "${BLUE}🗑️  Removing Kubernetes resources...${NC}"
kubectl delete -f k8s/ --ignore-not-found=true
echo -e "${GREEN}✅ All resources removed${NC}"

# Show remaining resources
echo -e "${BLUE}📊 Remaining resources:${NC}"
kubectl get all

echo -e "${GREEN}🎉 Cleanup completed successfully!${NC}"
