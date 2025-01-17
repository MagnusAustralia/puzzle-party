# Use the official Rust image as the base
FROM rust:latest

# Install dependencies for building your package
RUN apt-get update && apt-get install -y libssl-dev pkg-config

# Install maturin
RUN pip install maturin

# Set the working directory
WORKDIR /app

# Copy the Cargo.toml and Cargo.lock files
COPY Cargo.toml Cargo.lock ./

# Update Cargo if necessary
RUN cargo update

# Copy the rest of the project
COPY . .

# Build the project (if needed)
RUN maturin build --release