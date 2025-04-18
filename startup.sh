#### This is my dump of the startup script for the webui container
### DO NOT EXECUTE THIS SCRIPT

docker run -itd \
  --gpus all \
  -v banzo_ollama_data:/data/ollama \
  -v banzo_webui_data:/data/open-webui \
  -e TUNNEL_TOKEN="YOUR_TUNNEL_TOKEN" \
  --name banzo-webui-container \
  my-webui-app-image:latest 


docker run -d -p 3000:8080 --gpus=all -v ollama:/root/.ollama -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:ollama

docker run -itd --gpus all \
  --name banzo-webui-debug-container \
  --restart always \
  -e CLOUDFLARED_TUNNEL_TOKEN=${TUNNEL_TOKEN} \
  banzo-openwebui-debug:3


docker build -t banzo-openwebui-debug:3 .
docker build -t banzo/openwebui-custom:latest .

docker run -itd --gpus all \
  --name banzo-webui-container \
  --restart always \
  -v /path/to/your/ollama_data:/root/.ollama \
  -v /path/to/your/openwebui_data:/app/backend/data \
  -e CLOUDFLARED_TUNNEL_TOKEN=${TUNNEL_TOKEN} \
  banzo/openwebui-custom


# Compose setup
docker-compose up -d --build
docker-compose up -d
docker compose build
docker-compose down