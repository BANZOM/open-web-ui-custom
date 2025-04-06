#!/bin/bash
set -e

# Run Cloudflared with the tunnel token
if [ -z "$CLOUDFLARED_TUNNEL_TOKEN" ]; then
    echo "Error: CLOUDFLARED_TUNNEL_TOKEN environment variable not set."
    exit 1
fi

echo "Starting Cloudflared tunnel..."
cloudflared tunnel --no-autoupdate run --token "$CLOUDFLARED_TUNNEL_TOKEN"
echo "Cloudflared tunnel finished."

if [ -f "/app/backend/start.sh" ]; then
    /bin/bash /app/backend/start.sh
else
    echo "Error: /app/backend/start.sh not found in base image."
    exit 1
fi

# Keep the container running
tail -f /dev/null