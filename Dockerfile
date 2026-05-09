FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Install dependencies first (for caching)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY service/ ./service/

# Create a non-root user 'theia' for security
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# Expose the application port
EXPOSE 8080

# Run the service using Gunicorn
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]


