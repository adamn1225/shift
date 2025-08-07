FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    wkhtmltopdf \
    libreoffice \
    ghostscript \
    qpdf \
    pandoc \
    tesseract-ocr \
    tesseract-ocr-eng \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Install the shift package
COPY . .
RUN pip install -e .

# Copy application code
COPY *.py ./
COPY *.css ./

# Create workspace directory
RUN mkdir /workspace
WORKDIR /workspace

# Make all shift commands available
ENV PATH="/app:$PATH"

# Default to main shift command, but allow override
ENTRYPOINT ["shift"]
