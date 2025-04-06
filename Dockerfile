FROM python:3.11-slim-bookworm

LABEL maintainer="Aditya Panwar <aditya.panwar.2208@gmail.com>"
LABEL description="Image with Ollama, Open WebUI, and Cloudflared (Token-Based)"

WORKDIR /app

ENV OLLAMA_HOST=0.0.0.0 \
    PYTHONUNBUFFERED=1 \
    WEBUI_DATA_DIR=/data/open-webui \
    OLLAMA_MODELS=/data/ollama

EXPOSE 8080 11434

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    pciutils \
    && \
    echo "Installing Ollama..." && \
    curl -fsSL https://ollama.com/install.sh | sh && \
    echo "Installing uv..." && \
    curl -LsSf https://astral.sh/uv/install.sh | sh && \
    echo "Installing Cloudflared..." && \
    CLOUDFLARED_VERSION=$(curl -s https://api.github.com/repos/cloudflare/cloudflared/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")') && \
    curl -L --output cloudflared.deb "https://github.com/cloudflare/cloudflared/releases/download/${CLOUDFLARED_VERSION}/cloudflared-linux-amd64.deb" && \
    dpkg -i cloudflared.deb && \
    rm cloudflared.deb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV PATH="/root/.cargo/bin:${PATH}"

RUN echo "Installing Open WebUI..." && \
    uv pip install --system open-webui --no-cache

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

RUN mkdir -p "$WEBUI_DATA_DIR" "$OLLAMA_MODELS"

ENTRYPOINT ["/app/entrypoint.sh"]