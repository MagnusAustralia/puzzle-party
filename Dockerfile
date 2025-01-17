# Use a Rust base image
FROM rust:1.73-slim

# Install Python, pip, and build dependencies
RUN apt-get update && apt-get install -y \
    python3 python3-pip python3-venv build-essential libssl-dev \
    && apt-get clean

# Set the working directory inside the container
WORKDIR /app

# Copy only the project files (excluding the local `.venv`)
COPY . .

# Create and activate a virtual environment inside the container
RUN python3 -m venv .venv \
    && .venv/bin/pip install --upgrade pip \
    && .venv/bin/pip install maturin

# Add the virtual environment to PATH
ENV PATH="/app/.venv/bin:$PATH"

# Default command to publish the project to PyPI
CMD ["maturin", "publish", "--username", "$PYPI_USERNAME", "--password", "$PYPI_PASSWORD"]

