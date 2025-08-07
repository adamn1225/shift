# Shift Docker Deployment Guide

## Local Development

### Build and run with Docker Compose
```bash
# Build the image
docker-compose build

# Run interactive container
docker-compose run --rm shift

# Inside container, use any shift command:
shift document.docx --to pdf
shift-compress large.pdf
shift-pages document.pdf --analyze
```

### Single Docker Commands
```bash
# Build image
docker build -t shift:latest .

# Run with volume mounts
docker run -it --rm \
  -v $(pwd)/input:/input \
  -v $(pwd)/output:/output \
  shift:latest document.docx --to pdf --output /output/result.pdf

# Run different tools
docker run -it --rm -v $(pwd):/workspace shift:latest /bin/bash
# Inside: shift-compress file.pdf
```

## Cloud Deployment Options

### 1. Docker Hub / Container Registry
```bash
# Tag and push to Docker Hub
docker tag shift:latest yourusername/shift:latest
docker push yourusername/shift:latest

# Or use GitHub Container Registry
docker tag shift:latest ghcr.io/yourusername/shift:latest
docker push ghcr.io/yourusername/shift:latest
```

### 2. AWS Deployment

#### AWS ECS (Fargate)
- Upload to Amazon ECR
- Create ECS task definition
- Run as serverless containers
- Good for batch processing

#### AWS Lambda (with container)
- Package as container image
- Deploy to Lambda for serverless execution
- Perfect for single file conversions
- 15-minute execution limit

### 3. Google Cloud Platform

#### Cloud Run
```bash
# Deploy to Cloud Run
gcloud run deploy shift \
  --image gcr.io/PROJECT-ID/shift \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated
```

#### Google Kubernetes Engine (GKE)
- Full Kubernetes deployment
- Scaling and load balancing
- Good for high-volume processing

### 4. Azure Container Instances
```bash
# Deploy to Azure
az container create \
  --resource-group myResourceGroup \
  --name shift-container \
  --image yourusername/shift:latest \
  --cpu 2 --memory 4
```

### 5. Digital Ocean App Platform
- Simple container deployment
- Automatic scaling
- Built-in CI/CD

### 6. Railway / Render / Fly.io
- Simple deployment from GitHub
- Automatic builds
- Good for web interfaces

## Web Interface Deployment

If you want to create a web interface:

1. **Add Flask/FastAPI web server**
2. **Deploy to platforms like:**
   - Heroku (simple)
   - Vercel (with serverless functions)
   - Railway (containers)
   - DigitalOcean App Platform

## Batch Processing Deployment

For automated batch processing:

1. **AWS Batch** - Large-scale batch jobs
2. **Google Cloud Batch** - Managed batch processing
3. **Kubernetes CronJobs** - Scheduled processing
4. **GitHub Actions** - CI/CD triggered processing

## Environment Variables for Production

```bash
# Production settings
SHIFT_MAX_FILE_SIZE=100MB
SHIFT_TEMP_DIR=/tmp/shift
SHIFT_LOG_LEVEL=INFO
SHIFT_ALLOWED_FORMATS=pdf,docx,md,html,txt
```

## Usage Examples by Platform

### Local Docker
```bash
docker run --rm -v $(pwd):/workspace shift report.md --to pdf
```

### Cloud Run (HTTP endpoint)
```bash
curl -X POST https://shift-service.run.app/convert \
  -F "file=@document.docx" \
  -F "to=pdf"
```

### AWS Lambda (API Gateway)
```bash
aws lambda invoke \
  --function-name shift-converter \
  --payload '{"file": "base64data", "to": "pdf"}' \
  response.json
```
