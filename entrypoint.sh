#!/bin/bash
set -e

# Run Cloudflared with the tunnel token
if [ -z "$CLOUDFLARED_TUNNEL_TOKEN" ]; then
    echo "Error: CLOUDFLARED_TUNNEL_TOKEN environment variable not set."
    exit 1
fi

echo "Starting Cloudflared tunnel..."
cloudflared tunnel --no-autoupdate run --token "$CLOUDFLARED_TUNNEL_TOKEN" >> /app/backend/cloudflared.logs 2>&1 &
CLOUDFLARED_PID=$!
sleep 5
if  ! kill -0 "$CLOUDFLARED_PID"; then
    echo "Error: Cloudflared tunnel failed to start."
    exit 1
fi
echo "Cloudflared tunnel started."

if [ -f "/app/backend/start.sh" ]; then
    echo "Starting application..."
    /bin/bash /app/backend/start.sh
else
    echo "Error: /app/backend/start.sh not found in base image."
    exit 1
fi