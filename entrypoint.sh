#!/bin/bash
set -e

if [ -f "/app/backend/start.sh" ]; then
    /bin/bash /app/backend/start.sh
else
    echo "Error: /app/backend/start.sh not found in base image."
    exit 1
fi


