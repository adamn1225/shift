#!/bin/bash
# Deploy Shift to Google Cloud Run

set -e

echo "🚀 Deploying Shift to Google Cloud Run"
echo "======================================"

# Check if gcloud is installed
if ! command -v gcloud &> /dev/null; then
    echo "❌ Google Cloud CLI not found!"
    echo "Install from: https://cloud.google.com/sdk/docs/install"
    exit 1
fi

# Get project info
read -p "Enter your Google Cloud Project ID: " PROJECT_ID
read -p "Enter your preferred region (default: us-central1): " REGION
REGION=${REGION:-us-central1}
read -p "Enter service name (default: shift-web): " SERVICE_NAME
SERVICE_NAME=${SERVICE_NAME:-shift-web}

echo ""
echo "📋 Deployment Configuration:"
echo "   Project: $PROJECT_ID"
echo "   Region: $REGION"
echo "   Service: $SERVICE_NAME"
echo ""

# Set project
echo "🔧 Setting up Google Cloud project..."
gcloud config set project $PROJECT_ID

# Enable required APIs
echo "🔌 Enabling required APIs..."
gcloud services enable cloudbuild.googleapis.com
gcloud services enable run.googleapis.com
gcloud services enable containerregistry.googleapis.com

# Build and submit to Cloud Build
echo "🏗️  Building container image..."
IMAGE_URL="gcr.io/$PROJECT_ID/$SERVICE_NAME"

gcloud builds submit --tag $IMAGE_URL --file Dockerfile.web .

# Deploy to Cloud Run
echo "🚀 Deploying to Cloud Run..."
gcloud run deploy $SERVICE_NAME \
    --image $IMAGE_URL \
    --platform managed \
    --region $REGION \
    --allow-unauthenticated \
    --memory 2Gi \
    --cpu 2 \
    --timeout 300 \
    --max-instances 10 \
    --set-env-vars "PYTHONUNBUFFERED=1"

# Get the service URL
SERVICE_URL=$(gcloud run services describe $SERVICE_NAME --platform managed --region $REGION --format 'value(status.url)')

echo ""
echo "✅ Deployment Complete!"
echo "🌐 Your Shift web service is available at:"
echo "   $SERVICE_URL"
echo ""
echo "🧪 Test your deployment:"
echo "   curl $SERVICE_URL/health"
echo "   # Or visit $SERVICE_URL in your browser"
echo ""
echo "🔧 Update your CLI wrapper:"
echo "   export SHIFT_SERVICE_URL='$SERVICE_URL'"
echo "   shift-cloud document.docx --to pdf"
echo ""

# Optionally set up custom domain
echo "🌍 Optional: Set up custom domain"
echo "   gcloud run domain-mappings create --service $SERVICE_NAME --domain your-domain.com --region $REGION"
