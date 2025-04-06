#!/bin/sh
set -e

# Default DATA_DIR if not set externally
export DATA_DIR=${WEBUI_DATA_DIR:-/data/open-webui}
export OLLAMA_MODELS=${OLLAMA_MODELS:-/data/ollama}
mkdir -p "$DATA_DIR" "$OLLAMA_MODELS"

echo "Starting Ollama..."
ollama serve >> ollama.logs &
sleep 5

echo "Starting Open WebUI..."
open-webui serve --host 0.0.0.0 --port 8080 >> webui.logs &

echo "Starting Cloudflared..."
# Use the tunnel token from the Cloudflare dashboard
# Make the token an environment variable for easy configuration
TUNNEL_TOKEN=${TUNNEL_TOKEN:?"Error: TUNNEL_TOKEN environment variable not set"}
exec cloudflared tunnel --no-autoupdate run --token "$TUNNEL_TOKEN"