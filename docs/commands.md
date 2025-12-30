# Stratos Project - GCloud Command Reference

## Configuration
### Switch Projects
```bash
# List available projects
gcloud projects list

# Set active project
gcloud config set project [PROJECT_ID]

# Verify active project
gcloud config get-value project
```

## Infrastructure Setup
### Enable APIs
```bash
gcloud services enable artifactregistry.googleapis.com run.googleapis.com cloudbuild.googleapis.com
```

### Artifact Registry
```bash
# Create repository
gcloud artifacts repositories create stratos-repo \
    --repository-format=docker \
    --location=us-central1 \
    --description="Docker repository for Project Stratos"

# Delete repository (Cleanup)
gcloud artifacts repositories delete stratos-repo --location us-central1
```

### IAM Permissions (Fix for Cloud Build)
```bash
# Grant Storage Object Viewer to Compute Engine Service Account
PROJECT_NUMBER=$(gcloud projects describe $(gcloud config get-value project) --format="value(projectNumber)")

gcloud projects add-iam-policy-binding $(gcloud config get-value project) \
    --member=serviceAccount:${PROJECT_NUMBER}-compute@developer.gserviceaccount.com \
    --role=roles/storage.objectViewer
```

## Build & Deploy
### Manual Build & Deploy
```bash
# Submit build to Cloud Build
gcloud builds submit --tag us-central1-docker.pkg.dev/$(gcloud config get-value project)/stratos-repo/stratos-app:v1

# Deploy to Cloud Run
gcloud run deploy stratos-app \
    --image us-central1-docker.pkg.dev/$(gcloud config get-value project)/stratos-repo/stratos-app:v1 \
    --region us-central1 \
    --allow-unauthenticated
```

### Cloud Run Cleanup
```bash
# Delete Cloud Run service
gcloud run services delete stratos-app --region us-central1
```

## Monitoring & Troubleshooting
### Cloud Build
```bash
# List recent builds
gcloud builds list

# Stream logs for a specific build
gcloud builds log [BUILD_ID] --stream
```