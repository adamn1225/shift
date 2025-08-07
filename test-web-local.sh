#!/bin/bash
# Test the web interface locally before deploying to Cloud Run

echo "🧪 Testing Shift Web Interface Locally"
echo "====================================="

# Build the web Docker image
echo "🏗️  Building web interface Docker image..."
docker build -f Dockerfile.web -t shift-web-test .

# Run the container
echo "🚀 Starting web interface on http://localhost:8080"
echo "   Press Ctrl+C to stop"
echo ""

# Run with port mapping
docker run --rm -p 8080:8080 shift-web-test
