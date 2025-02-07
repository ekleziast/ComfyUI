# Use the official NVIDIA CUDA image as the base
FROM nvidia/cuda:12.1.1-cudnn8-devel-ubuntu22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

ENV VIRTUAL_ENV=/comfy
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    python3 \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Expose the default port
EXPOSE $PORT

# Start ComfyUI
CMD ["sh", "-c", "source $VIRTUAL_ENV/bin/activate && python3 main.py --listen 0.0.0.0 --port $PORT --cuda-device $DEVICE_ID --highvram"]
