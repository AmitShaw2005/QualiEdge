# Multi-stage Dockerfile for QualiEdge Industrial Quality Control
FROM python:3.11-slim

# System dependencies for OpenCV & headless execution
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgl1 \
    libglib2.0-0 \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy requirements and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application source code and models
COPY backend/ ./backend/
COPY cv_pipeline/ ./cv_pipeline/
COPY advisory_engine/ ./advisory_engine/
COPY models/ ./models/
COPY data/ ./data/

# Environment variables
ENV PORT=8000
ENV PYTHONUNBUFFERED=1

EXPOSE 8000

# Healthcheck
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD curl -f http://localhost:8000/api/health || exit 1

CMD ["python", "backend/main.py"]
