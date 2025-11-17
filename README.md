# 🏠 Madrid House Price Prediction — MLOps Project

An end-to-end MLOps system for predicting Madrid house prices.  
It covers data preparation, model training (with MLflow tracking), Dockerized serving via FastAPI, and continuous deployment on Render.

---

## 🚀 Project Overview
Pipeline Stages

Data & Training – Cleans and processes housing data, trains a RandomForestRegressor, logs metrics to MLflow.

Model Serving – A FastAPI app serves predictions using the trained model.

Containerization – The app and model are packaged in a Docker image.

CI/CD Automation – GitHub Actions handle training, model artifact upload, and Docker builds.

Deployment – The Docker image is automatically built and deployed to Render with a live endpoint.

---

## 📂 Repository Structure
| Path                              | Description                              |
|-----------------------------------|------------------------------------------|
| `madrid_mlops_project/`           | Root project directory                   |
| ├── `app/app.py`                  | FastAPI app for serving predictions      |
| ├── `data/madrid_sample.csv`      | Sample dataset for CI                    |
| ├── `models/model.pkl`            | Trained model                            |
| ├── `src/data_cleaning.py`        | Data preprocessing                       |
| ├── `src/train_model.py`          | Model training + MLflow logging          |
| ├── `.github/workflows/train.yml` | Train workflow                           |
| ├── `.github/workflows/docker.yml`| Docker build workflow                    |
| ├── `Dockerfile`                  | Container build instructions             |
| ├── `render.yaml`                 | Render deployment manifest               |
| ├── `requirements-train-ci.txt`   | Training dependencies for CI             |
| ├── `requirements-api.txt`        | Runtime dependencies for FastAPI         |
| └── `README.md`                   | Project documentation                    |

⚙️ Local Setup
1️⃣ Create and activate a virtual environment
python -m venv venv
venv\Scripts\activate      # Windows
# or
source venv/bin/activate   # macOS/Linux

2️⃣ Install dependencies

For training:

pip install -r requirements-train-ci.txt


For serving:

pip install -r requirements-api.txt

3️⃣ Train the model locally
python src/train_model.py data/house_price_madrid_14_08_2022.csv


Model is saved to models/model.pkl

Metrics and parameters are logged in MLflow (mlruns/)

4️⃣ Run the API locally
uvicorn app.app:app --host 0.0.0.0 --port 8000


Visit the docs at: http://127.0.0.1:8000/docs

🧪 Example Prediction

POST /predict

[
  {
    "m2": 85,
    "rooms": 3,
    "elevator": 1,
    "garage": 0,
    "house_type": "piso",
    "house_type_2": "reformado",
    "neighborhood": "sol",
    "district": "centro"
  }
]

Response

{
  "count": 1,
  "log_price": [11.05],
  "price": [63000.42]
}

🔁 CI/CD Workflows
🧠 train.yml

Runs on every push to main

Installs lightweight dependencies for Linux

Trains on a small sample dataset (data/madrid_sample.csv)

Uploads models/model.pkl as a GitHub Actions artifact

🐳 docker.yml

Downloads the model artifact

Builds the FastAPI Docker image

Pushes image to GitHub Container Registry (GHCR)

Optionally runs a smoke test

☁️ Deployment (Render)

Render Settings

Setting	Value
Runtime	Docker
Branch	main
Port	8000
Health Check Path	/healthz
Auto Deploy	Enabled

Live Endpoint

https://madrid-house-price-api.onrender.com


/healthz → Service health

/docs → Swagger UI

/predict → Predict prices

🧰 Tools & Technologies
Category	Tools
Data & Model	pandas, scikit-learn, joblib
Tracking	MLflow
API	FastAPI, Uvicorn
CI/CD	GitHub Actions, Docker, GHCR
Deployment	Render.com

