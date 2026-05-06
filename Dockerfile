FROM ollama/ollama:latest

LABEL maintainer="Agnuxo1 <contact@p2pclaw.com>"
LABEL description="CAJAL-9B Scientific Paper Generation Model for KServe"

# Install huggingface-cli and dependencies
RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-venv \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache-dir huggingface-hub

# Create model directory
RUN mkdir -p /models/cajal

# Download CAJAL-9B model weights
# Using a build arg for HF token if needed
ARG HF_TOKEN=""
ENV HF_TOKEN=${HF_TOKEN}
RUN if [ -n "$HF_TOKEN" ]; then \
        huggingface-cli login --token "$HF_TOKEN"; \
    fi

RUN huggingface-cli download Agnuxo/CAJAL-9B-P2PCLAW \
    --local-dir /models/cajal \
    --include "*.gguf" "Modelfile" "README.md"

# Create Ollama model
RUN ollama serve & \
    sleep 5 && \
    ollama create cajal -f /models/cajal/Modelfile && \
    pkill ollama

# Expose Ollama API port
EXPOSE 11434

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:11434/api/tags || exit 1

# Start Ollama server
CMD ["ollama", "serve"]
