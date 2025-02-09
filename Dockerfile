# Use the official NVIDIA CUDA image as the base
FROM nvidia/cuda:12.2.0-runtime-ubuntu22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

ENV VIRTUAL_ENV=/comfy
ENV PATH="${VIRTUAL_ENV}/bin:$PATH"

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    python3.10 \
    python3-pip \
    python3-venv \
    ffmpeg \
    libsm6 \
    libxext6 \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN python3.10 -m venv ${VIRTUAL_ENV} && \
    ${VIRTUAL_ENV}/bin/pip install --upgrade pip && \
    ${VIRTUAL_ENV}/bin/pip install -r requirements.txt

WORKDIR /app

COPY custom_nodes/ custom_nodes/

RUN python3.10 custom_nodes/install_requirements.py

# Expose the default port
EXPOSE $PORT

# Start ComfyUI
CMD ["sh", "-c", ". ${VIRTUAL_ENV}/bin/activate && python3.10 main.py --listen 0.0.0.0 --port $PORT --cuda-device 0 --highvram"]
