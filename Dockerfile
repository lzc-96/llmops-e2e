# Builder
FROM python:3.11-slim AS builder

# Set the working directory in the container
WORKDIR /app

# Install system deps (needed for transformers/TensorFlow)
# RUN apt-get update && apt-get install -y --no-install-recommends \
#     build-essential && \
#     apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy only the requirements file to leverage Docker cache
COPY requirements.txt .

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code to the working directory
COPY . .

# Runtime
FROM python:3.11-slim

WORKDIR /app

# Copy installed packages from builder
COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY --from=builder /app /app

# Run app
CMD ["python", "day02.py"]

# Expose port 8000
# EXPOSE 8000

# Use a minimal entrypoint and CMD
# ENTRYPOINT ["python"]
# CMD ["day02.py"]

# Use Uvicorn to serve FastAPI app
# CMD ["uvicorn", "day02:app", "--host", "0.0.0.0", "--port", "8000"]
