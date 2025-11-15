# Use small Python image
FROM python:3.11-slim

# Install minimal system libraries (needed by scikit-learn)
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgomp1 \
 && rm -rf /var/lib/apt/lists/*

# Set working directory inside container
WORKDIR /app

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements-api.txt

# Copy FastAPI app and trained model
COPY app/ app/
COPY models/ models/

# Expose port 8000 for the API
EXPOSE 8000

# Start FastAPI using Uvicorn
CMD ["uvicorn", "app.app:app", "--host", "0.0.0.0", "--port", "8000"]
