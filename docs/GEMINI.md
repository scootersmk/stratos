# Project Stratos: Production GitOps Lab

## 🎯 Vision
A production-grade, global-scale web application hosted on Google Cloud Platform (GCP). The goal is to implement industry-standard GitOps workflows, high-availability architecture, and transparent technology tracking while maintaining a low cost-to-run.

## 🏗 System Architecture
- **Compute:** Google Cloud Run (Fully managed serverless containers).
- **CI/CD & GitOps:** Cloud Build (Triggered by GitHub pushes).
- **IaC:** Terraform (State stored in GCS bucket: `[YOUR-PROJECT-ID]-tfstate`).
- **Networking:** Initially Direct Cloud Run URLs; transitioning to Global External HTTP(S) Load Balancer + Cloud CDN.
- **Database:** Firestore (Native Mode) for scale-to-zero persistence.
- **Observability:** Google Cloud Operations Suite (Logging/Monitoring).

## 🛠 Tech Stack
- **Runtime:** Node.js 20 (Express.js)
- **Containerization:** Docker (slim-image based)
- **Registry:** GCP Artifact Registry
- **Framework Goal:** High-introspection (App reports its own version/region/metadata).

## 📈 Roadmap & Milestones
- [x] **Milestone 1: Foundation** - Project creation, GitHub linkage, and manual Cloud Run deploy.
- [x] **Milestone 2: Automated Pipeline** - `cloudbuild.yaml` implementation for auto-deploy on push.
- [x] **Milestone 3: Infrastructure as Code** - Replacing manual setup with Terraform manifests.
- [x] **Milestone 4: Traffic Management** - Implementing Canary releases and Blue/Green deployments.
- [ ] **Milestone 5: Global Scale** - Configuring Global Load Balancer, CDN, and Custom Domains.

## 💰 Cost Constraints
- Aim for **Free Tier** usage during initial development.
- Max budget for "Global Scale" features: **~$20/month** (primarily for Load Balancer Forwarding Rules).
- No persistent VMs (Compute Engine) or idle Cloud SQL instances.

## 📝 Developer Notes
- Use `us-central1` as the primary region for maximum free-tier compatibility.
- All infrastructure changes **must** be reflected in Terraform (GitOps principle).
- App versioning follows Semantic Versioning (SemVer) via Git tags.