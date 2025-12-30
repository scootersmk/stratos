terraform {
  required_version = ">= 1.0"
  backend "gcs" {
    bucket  = "stratos-482518-tfstate"
    prefix  = "terraform/state"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# 1. Artifact Registry
resource "google_artifact_registry_repository" "repo" {
  location      = var.region
  repository_id = "stratos-repo"
  description   = "Docker repository for Project Stratos"
  format        = "DOCKER"
}

# 2. Cloud Run Service
resource "google_cloud_run_service" "default" {
  name     = "stratos-app"
  location = var.region

  template {
    spec {
      containers {
        image = "us-central1-docker.pkg.dev/${var.project_id}/stratos-repo/stratos-app:v1"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  lifecycle {
    ignore_changes = [
      template[0].spec[0].containers[0].image,
      template[0].metadata[0].annotations,
    ]
  }
}

# 3. Public Access (IAM)
resource "google_cloud_run_service_iam_member" "public_access" {
  service  = google_cloud_run_service.default.name
  location = google_cloud_run_service.default.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}