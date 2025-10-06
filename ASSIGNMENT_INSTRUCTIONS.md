# Assignment Submission Instructions

## 🎯 Assignment Overview
This repository contains a complete full-stack microservices application deployed on Kubernetes with:
- **React Frontend**: Clean UI for CRUD operations
- **Spring Boot Backend**: RESTful API with Item management
- **Kubernetes Deployment**: 2 replicas each with proper service discovery
- **Docker Hub Integration**: Production-ready container images

## 🚀 Quick Start (For Assignment Submission)

### 1. Prerequisites
- Docker Desktop with Kubernetes enabled
- Docker Hub account
- kubectl command-line tool

### 2. Deploy the Application
```bash
# Clone the repository
git clone <your-repo-url>
cd my-spring-containerr

# Deploy using automated script (replace with your Docker Hub username)
./deploy.sh <your-dockerhub-username>

# Example:
./deploy.sh johndoe
```

### 3. Verify Deployment
```bash
# Check all resources are running
kubectl get all

# Expected output:
# - 2 Spring Boot pods
# - 2 React pods  
# - 2 Services
# - Total: 4 pods with STATUS = Running
```

### 4. Test the Application
```bash
# Run automated tests
./test-deployment.sh

# Or manually test:
# 1. Open http://localhost:30080 in browser
# 2. Test all CRUD operations
# 3. Verify data persists after refresh
```

### 5. Take Screenshots
Take screenshots of:
1. **kubectl get all** output showing all resources running
2. **React UI in browser** with URL visible (http://localhost:30080)
3. **CRUD operation working** - evidence of create/read/update/delete

Save screenshots in the `screenshots/` directory.

### 6. Cleanup (Optional)
```bash
# Remove all Kubernetes resources
./cleanup.sh
```

## 📋 Assignment Checklist

### ✅ Completed Requirements
- [x] React frontend with CRUD operations
- [x] Spring Boot RESTful API
- [x] Containerized applications (Docker Hub ready)
- [x] Kubernetes deployment with 2 replicas each
- [x] Service discovery and networking
- [x] All 4 YAML manifests (2 deployments, 2 services)
- [x] Comprehensive README with instructions
- [x] Automated deployment scripts
- [x] Testing scripts
- [ ] Screenshots of working application

### 📁 Repository Structure
```
my-spring-containerr/
├── README.md                    # Complete documentation
├── ASSIGNMENT_INSTRUCTIONS.md   # This file
├── deploy.sh                    # Automated deployment
├── cleanup.sh                   # Automated cleanup
├── test-deployment.sh           # Testing script
├── build.gradle                 # Spring Boot build
├── Dockerfile                   # Spring Boot container
├── screenshots/                 # Screenshots directory
├── k8s/                         # Kubernetes manifests
│   ├── spring-deployment.yaml   # Spring deployment (2 replicas)
│   ├── spring-service.yaml      # Spring service (ClusterIP)
│   ├── react-deployment.yaml    # React deployment (2 replicas)
│   └── react-service.yaml       # React service (NodePort)
└── react-app/                   # React frontend
    ├── Dockerfile               # React container
    ├── nginx.conf               # NGINX config
    └── src/                     # React source code
```

## 🔧 Technical Details

### API Endpoints
- `GET /api/items` - List all items
- `GET /api/items/{id}` - Get item by ID
- `POST /api/items` - Create new item
- `PUT /api/items/{id}` - Update item
- `DELETE /api/items/{id}` - Delete item

### Service Architecture
- **Spring Service**: ClusterIP on port 8080 (internal)
- **React Service**: NodePort on port 30080 (external access)
- **Service Discovery**: React connects to `spring-service:8080`

### Resource Configuration
- **Spring Boot**: 256Mi-512Mi RAM, 250m-500m CPU
- **React**: 64Mi-128Mi RAM, 50m-100m CPU
- **Replicas**: 2 each for high availability

## 🐛 Troubleshooting

### Common Issues
1. **ImagePullBackOff**: Ensure images are pushed to Docker Hub
2. **Pods Not Ready**: Check pod logs with `kubectl logs <pod-name>`
3. **Service Not Accessible**: Verify service endpoints with `kubectl get endpoints`

### Useful Commands
```bash
# Check pod status
kubectl get pods

# Check pod logs
kubectl logs -f deployment/spring-deployment
kubectl logs -f deployment/react-deployment

# Port forwarding for testing
kubectl port-forward service/spring-service 8081:8080
kubectl port-forward service/react-service 3001:80

# Delete all resources
kubectl delete -f k8s/
```

## 📝 Submission Notes

This application demonstrates:
- Full-stack microservices architecture
- Container orchestration with Kubernetes
- Service discovery and networking
- Production-ready deployment configuration
- Automated deployment and testing scripts
- Comprehensive documentation

The application is ready for production deployment and meets all assignment requirements.
