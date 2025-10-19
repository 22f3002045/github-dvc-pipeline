# Iris Classification DVC Pipeline

This project demonstrates a simple machine learning pipeline for classifying the Iris flower dataset. It uses a Decision Tree Classifier and is orchestrated using DVC (Data Version Control).

## Project Overview

The goal of this project is to train a model that can predict the species of an iris flower based on four features:

*   Sepal Length
*   Sepal Width
*   Petal Length
*   Petal Width

The pipeline consists of a single `train` stage that handles data loading, splitting, model training, and evaluation.

## Project Structure

```
├── artifacts
│   └── model.joblib    # Trained model artifact
├── data
│   └── iris.csv        # Raw dataset
├── test.py             # Sanity checks for the trained model
├── train.py            # Training script
└── python-test.yml     # DVC pipeline definition
```

## Getting Started

### Prerequisites

*   Python 3.8+
*   DVC

### Installation

1.  **Clone the repository:**
    ```bash
    git clone <your-repo-url>
    cd <your-repo-directory>
    ```

2.  **Install dependencies:**
    The required Python packages are `pandas`, `scikit-learn`, and `dvc`.
    ```bash
    pip install pandas scikit-learn "dvc[s3]" # or other remote storage
    ```

### Running the Pipeline

To execute the full pipeline and reproduce the `artifacts/model.joblib` file, run:

```bash
dvc repro -f python-test.yml
```

This command will execute the `train` stage defined in `python-test.yml`. It will train the model and save it to the `artifacts` directory.

### Testing the Model

After the pipeline has been successfully run, you can perform a sanity check on the generated model:

```bash
python test.py
```

You should see output indicating that all sanity checks have passed.
