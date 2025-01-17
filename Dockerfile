# Use the official Rust image as the base
FROM rust:latest

# Set the working directory
WORKDIR /app

# Copy the Cargo.toml and Cargo.lock files first
COPY Cargo.toml Cargo.lock ./

# Install dependencies (if needed)
RUN apt-get update && apt-get install -y \
    libssl-dev \
    pkg-config \
    python3 \
    python3-pip \
    python3-venv \
    pipx

RUN pipx install maturin

# Copy the rest of the source files
COPY . .

# Run cargo update and build the project
RUN cargo update && cargo build --release
