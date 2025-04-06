docker run -itd \
  --gpus all \
  -v banzo_ollama_data:/data/ollama \
  -v banzo_webui_data:/data/open-webui \
  -e TUNNEL_TOKEN="YOUR_TUNNEL_TOKEN" \
  --name banzo-webui-container \
  my-webui-app-image:latest 