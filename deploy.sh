#!/bin/bash
# Quick deployment script for common platforms

set -e

echo "🚀 Shift Deployment Helper"
echo "=========================="

# Function to build and test locally
build_local() {
    echo "📦 Building Docker image..."
    docker build -t shift:latest .
    
    echo "🧪 Testing build..."
    docker run --rm shift:latest --help
    
    echo "✅ Local build successful!"
}

# Function to deploy to Docker Hub
deploy_dockerhub() {
    read -p "Enter your Docker Hub username: " username
    read -p "Enter version tag (default: latest): " version
    version=${version:-latest}
    
    echo "🏷️  Tagging image..."
    docker tag shift:latest $username/shift:$version
    
    echo "⬆️  Pushing to Docker Hub..."
    docker push $username/shift:$version
    
    echo "✅ Deployed to Docker Hub: $username/shift:$version"
    echo "📋 Users can now run: docker run --rm $username/shift:$version"
}

# Function to deploy to GitHub Container Registry
deploy_github() {
    read -p "Enter your GitHub username: " username
    read -p "Enter repository name (default: shift): " repo
    repo=${repo:-shift}
    read -p "Enter version tag (default: latest): " version
    version=${version:-latest}
    
    echo "🏷️  Tagging image..."
    docker tag shift:latest ghcr.io/$username/$repo:$version
    
    echo "⬆️  Pushing to GitHub Container Registry..."
    docker push ghcr.io/$username/$repo:$version
    
    echo "✅ Deployed to GHCR: ghcr.io/$username/$repo:$version"
}

# Function to create Kubernetes deployment
create_k8s() {
    read -p "Enter container image (e.g., youruser/shift:latest): " image
    
    cat > k8s-deployment.yaml << EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: shift-converter
spec:
  replicas: 2
  selector:
    matchLabels:
      app: shift
  template:
    metadata:
      labels:
        app: shift
    spec:
      containers:
      - name: shift
        image: $image
        resources:
          requests:
            memory: "512Mi"
            cpu: "250m"
          limits:
            memory: "2Gi"
            cpu: "1"
        volumeMounts:
        - name: workspace
          mountPath: /workspace
      volumes:
      - name: workspace
        emptyDir: {}
---
apiVersion: v1
kind: Service
metadata:
  name: shift-service
spec:
  selector:
    app: shift
  ports:
  - port: 80
    targetPort: 8080
  type: LoadBalancer
EOF

    echo "✅ Created k8s-deployment.yaml"
    echo "📋 Deploy with: kubectl apply -f k8s-deployment.yaml"
}

# Function to create AWS ECS task definition
create_ecs() {
    read -p "Enter container image (e.g., youruser/shift:latest): " image
    
    cat > ecs-task-definition.json << EOF
{
  "family": "shift-converter",
  "networkMode": "awsvpc",
  "requiresCompatibilities": ["FARGATE"],
  "cpu": "1024",
  "memory": "2048",
  "executionRoleArn": "arn:aws:iam::YOUR_ACCOUNT:role/ecsTaskExecutionRole",
  "containerDefinitions": [
    {
      "name": "shift",
      "image": "$image",
      "essential": true,
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/shift-converter",
          "awslogs-region": "us-east-1",
          "awslogs-stream-prefix": "ecs"
        }
      },
      "environment": [
        {
          "name": "PYTHONUNBUFFERED",
          "value": "1"
        }
      ]
    }
  ]
}
EOF

    echo "✅ Created ecs-task-definition.json"
    echo "📋 Register with: aws ecs register-task-definition --cli-input-json file://ecs-task-definition.json"
}

# Main menu
echo "What would you like to do?"
echo "1) Build and test locally"
echo "2) Deploy to Docker Hub"
echo "3) Deploy to GitHub Container Registry"
echo "4) Create Kubernetes deployment files"
echo "5) Create AWS ECS task definition"
echo "6) Show deployment options"

read -p "Enter your choice (1-6): " choice

case $choice in
    1)
        build_local
        ;;
    2)
        build_local
        deploy_dockerhub
        ;;
    3)
        build_local
        deploy_github
        ;;
    4)
        create_k8s
        ;;
    5)
        create_ecs
        ;;
    6)
        echo "📖 See DEPLOYMENT.md for full deployment guide"
        echo "🌐 Recommended platforms:"
        echo "   - Docker Hub: Easy sharing"
        echo "   - Google Cloud Run: Serverless HTTP"
        echo "   - AWS Fargate: Serverless containers"
        echo "   - Railway/Render: Simple web deployment"
        ;;
    *)
        echo "❌ Invalid choice"
        exit 1
        ;;
esac

echo "🎉 Done!"
