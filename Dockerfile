# Builder
FROM python:3.9-slim

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

# Expose port 8000
EXPOSE 8000

# Run app
CMD ["python", "day02.py"]

# Use a minimal entrypoint and CMD
# ENTRYPOINT ["python"]
# CMD ["day02.py"]

# Use Uvicorn to serve FastAPI app
# CMD ["uvicorn", "day02:app", "--host", "0.0.0.0", "--port", "8000"]
