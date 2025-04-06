FROM ghcr.io/open-webui/open-webui:ollama

LABEL maintainer="Aditya Panwar <aditya.panwar.2208@gmail.com>"
LABEL description="Image with Ollama, Open WebUI, and Cloudflared (Token-Based)"

RUN echo "Installing Cloudflared..." && \
    CLOUDFLARED_VERSION=$(curl -s https://api.github.com/repos/cloudflare/cloudflared/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")') && \
    curl -L --output cloudflared.deb "https://github.com/cloudflare/cloudflared/releases/download/${CLOUDFLARED_VERSION}/cloudflared-linux-amd64.deb" && \
    dpkg -i cloudflared.deb && \
    rm cloudflared.deb

COPY entrypoint.sh .

ENTRYPOINT ["bash", "entrypoint.sh"]