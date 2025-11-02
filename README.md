# Iris ML Pipeline

Automated **CI/CD** pipeline for the Iris flower classification project, built with **DVC**, **MLflow**, **Docker**, and deployed to **Google Kubernetes Engine (GKE)** via **GitHub Actions**.

## 🚀 Project Overview

This repo demonstrates a complete end-to-end MLOps workflow:

* Data versioning and pipeline management with DVC.
* Model training and experiment tracking via MLflow.
* Containerizing the API (FastAPI) with Docker.
* Continuous Deployment (CD) of the API to GKE using GitHub Actions.
* Push of images to Google Artifact Registry for secure artifact storage.

## 📁 Repository Structure

```
├── data/                     ← Raw dataset (iris.csv)  
├── artifacts/                ← Trained model artifact(s)  
├── mlruns/                   ← MLflow experiment logs  
├── k8s/                      ← Kubernetes manifests (deployment + service)  
├── .github/workflows/        ← GitHub Actions CI/CD pipelines  
│   └── cd.yml  
├── dvc.yaml                  ← DVC pipeline definition  
├── params.yaml               ← Parameter configuration for pipeline  
├── train.py                  ← Training script (MLflow + multiple models)  
├── Dockerfile                ← Builds Iris API image  
├── README.md                 ← This file  
└── …  
```

## 🎯 Key Features

* **Reproducibility**: Changing parameters or data triggers only necessary stages via DVC (`dvc repro`).
* **Experiment tracking**: MLflow logs and compares accuracy across models.
* **Model serving**: FastAPI serves predictions using the best model artifact.
* **CI/CD pipeline**: On every push to `master`, GitHub Actions trains the model, builds and pushes Docker image, then deploys it automatically to GKE.
* **Cloud artifact storage**: Docker images stored in Google Artifact Registry.
* **Kubernetes deployment**: Automatically rolling-update API deployment on GKE.

## 🧠 High-Level Workflow

1. **Developer pushes** code or data changes to `master`.
2. GitHub Actions triggers the **CD workflow** (`cd.yml`).
3. The pipeline:

   * Installs dependencies (DVC, MLflow, etc.).
   * Runs the DVC stage(s) and `train.py` to produce the model artifact.
   * Checks that the model artifact exists.
   * Authenticates to Google Cloud via a service-account.
   * Builds and tags a Docker image.
   * Pushes image to Google Artifact Registry.
   * Fetches GKE credentials.
   * Applies or updates Kubernetes deployment & service on GKE.
4. The updated API is live and serving predictions.

## 🧩 Why DVC + MLflow?

* **DVC**: Helps version large data files and track pipeline stages with `dvc.yaml` and `dvc.lock`.
* **MLflow**: Tracks model training experiments, parameters, metrics and logs artifacts in `mlruns/`.
  Together they enable robust repeatability and transparency.

## 🐳 Docker & Kubernetes Overview

* **Docker container**: A self-contained runtime environment for the Iris API.
* **Kubernetes pod**: One or more Docker containers managed together by Kubernetes. In this project, each pod runs a single container of the API; Kubernetes handles scheduling, scaling, and resilience.
* **Kubernetes service**: Exposes the pod(s) externally via a LoadBalancer for the API endpoint.

## 🔧 Setup Instructions

1. Clone repository:

   ```bash
   git clone https://github.com/22f3002045/github-dvc-pipeline.git  
   cd github-dvc-pipeline  
   ```
2. Ensure dataset (`data/iris.csv`) is present in the repo.
3. Install dependencies:

   ```bash
   pip install -r requirements.txt  
   pip install dvc[gs] mlflow joblib  
   ```
4. Run the DVC pipeline:

   ```bash
   dvc repro  
   ```
5. Start the API locally (optional):

   ```bash
   docker build -t iris-api .  
   docker run -p 8080:8080 iris-api  
   ```
6. **CD workflow is automated**: Upon pushing to `master`, the full pipeline executes (train → build → push → deploy) with no manual steps required.

## 🛡️ Secrets / Configuration

The following GitHub repository **Secrets** must be configured:

* `GCP_SA_KEY` → Google Cloud Service Account JSON key (with roles: Artifact Registry Writer, Kubernetes Engine Developer).
* `GCP_PROJECT` → your Google Cloud project ID.
* `LOCATION` → Google Artifact Registry region (e.g., `us-central1`).
* `ARTIFACT_REPO` → name of the Artifact Registry repository (e.g., `iris-repo`).
* `GKE_CLUSTER` → name of your GKE cluster.
* `GKE_ZONE_OR_REGION` → zone or region of your cluster.

## 📌 Deployment Manifests

Kubernetes resources live in `k8s/`:

* `deployment.yaml` → describes the API deployment (image, replicas, ports).
* `service.yaml` → exposes the deployment as a LoadBalancer (port 80 → container port 8080).

## ✅ Success Criteria

* A new push to `master` triggers a GitHub Actions run that completes without errors.
* Docker image is pushed to the Artifact Registry.
* A new version of the API gets deployed to GKE and becomes accessible.
* You should be able to call the API’s `/predict` or `/health` endpoint successfully.

## 🎯 Future Enhancements

* Add **automatic rollback** on failed deployment.
* Add **horizontal pod autoscaling** based on CPU/memory.
* Add **monitoring and alerting** (Prometheus / Grafana).
* Add **canary deployments** or blue-green deployments.
* Integrate **feature store / data drift detection**.

---

### 📝 License & Credits

This project is open-source and available under the MIT License.
Credit for DVC concept: [https://dvc.org](https://dvc.org) ([Data Version Control · DVC][1])
