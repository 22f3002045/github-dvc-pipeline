# Dockerfile
FROM python:3.10-slim

WORKDIR /app

# system deps
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
 && rm -rf /var/lib/apt/lists/*

# copy requirements and install
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# copy app and artifacts (model)
COPY . .

ENV PORT=8080
EXPOSE 8080

# Use uvicorn as the server for FastAPI
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8080"]