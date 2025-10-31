
# 🌸 Iris ML Pipeline with DVC & MLflow

This project demonstrates a complete end-to-end Machine Learning workflow for the **Iris dataset**, integrated with **DVC (Data Version Control)** and **MLflow** for experiment tracking and reproducibility.

---

## 📁 Project Structure

```

iris_pipeline/
│
├── data/
│   ├── data_iris/
│   │   └── iris.csv
│   └── artifacts/
│       └── model_1.joblib
│
├── mlruns/                      # MLflow tracking and experiments
│
├── train.py                     # Model training script
├── test.py                      # Model testing/evaluation script
│
├── params.yaml                  # Configuration and hyperparameters
├── dvc.yaml                     # DVC pipeline definition
├── requirements.txt             # Python dependencies
└── README.md                    # Project documentation

---

## 🧠 DVC Pipeline Overview

### `train` Stage

* **Command:** `python3 train.py`
* **Dependencies:** `train.py`, Iris dataset (`iris.csv`)
* **Outputs:** Trained model (`model_1.joblib`)

### `test` Stage

* **Command:** `python3 test.py`
* **Dependencies:** `test.py`, trained model
* **Outputs:** `logs/sanity_check.log`

---
```
## 🚀 Running the Pipeline

### Step 1: Initialize DVC and Git

```bash
git init
dvc init

```
### Step 2: Reproduce the pipeline

```bash
dvc repro
```

### Step 3: View pipeline stages

```bash
dvc dag
```

### Step 4: Track experiments with MLflow

```bash
mlflow ui --backend-store-uri file:///mlruns
```

Then open your browser at [http://localhost:5000](http://localhost:5000).

---

## 📊 Outputs

* Trained model stored at:
  `data/artifacts/model_1.joblib`
* Logs and evaluation report:
  `logs/sanity_check.log`
* Experiment tracking data:
  `mlruns/`

---

## 🧰 Requirements

Install dependencies:

```bash
pip install -r requirements.txt
```

Typical libraries:

```
scikit-learn
pandas
numpy
mlflow
dvc
joblib
```

---

## 🏗️ Future Enhancements


* Containerize with Docker for deployment
* Add to Kubernetes Engine in GCP


---

## ✨ Author

**Adarshom Panigrahi**
*Data Science Student | Open Source Contributor*
📧 [adarshom.panigrahi333@gmail.com](mailto:adarshom.panigrahi333@gmail.com)

---


