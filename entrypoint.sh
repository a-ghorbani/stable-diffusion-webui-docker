#!/bin/sh

cd /content/stable-diffusion-webui

# Ensure the data directory exists
mkdir -p /content/stable-diffusion-webui/data

# Copy ui-config.json if it doesn't exist in the data directory
if [ ! -f /content/stable-diffusion-webui/data/ui-config.json ] && [ -f /content/stable-diffusion-webui/ui-config.json ]; then
  cp /content/stable-diffusion-webui/ui-config.json /content/stable-diffusion-webui/data/ui-config.json
fi

# Copy styles.csv if it doesn't exist in the data directory but exists in /content/stable-diffusion-webui
if [ ! -f /content/stable-diffusion-webui/data/styles.csv ] && [ -f /content/stable-diffusion-webui/styles.csv ]; then
  cp /content/stable-diffusion-webui/styles.csv /content/stable-diffusion-webui/data/styles.csv
fi

# Execute the main command
exec python webui.py --xformers --listen --enable-insecure-extension-access --gradio-queue --theme dark \
    --clip-models-path /content/stable-diffusion-webui/models/CLIP --ckpt-dir /content/fused-models \
    --lora-dir /content/fused-lora --multiple \
    --ui-config-file /content/stable-diffusion-webui/data/ui-config.json \
    --styles-file /content/stable-diffusion-webui/data/styles.csv
