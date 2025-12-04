# Use the official Python image from the Docker Hub
FROM python:3.10

# Set the working directory in the container
WORKDIR /app

# Copy only the requirements file to leverage Docker cache
COPY requirements.txt .

# Upgrade pip first, then install dependencies
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code to the working directory
COPY . .

# Expose port 8000
EXPOSE 8000

# Use a minimal entrypoint and CMD
# ENTRYPOINT ["python"]
# CMD ["day02.py"]

# Use Uvicorn to serve FastAPI app
CMD ["uvicorn", "day02:app", "--host", "0.0.0.0", "--port", "8000"]
