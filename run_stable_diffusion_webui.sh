#!/bin/bash

# Set the default tag to 'base'
DEFAULT_TAG="base"

# Help message
help_message() {
  echo "Usage: $0 [TAG | -h | --help]"
  echo "Runs the aghorbani/stable-diffusion-webui Docker image with the specified or default tag and mounts the local outputs directory."
  echo ""
  echo "Arguments:"
  echo "  TAG       The Docker image tag to use (default: base)"
  echo "  -h, --help  Show this help message and exit"
}

# Check if the user provided a tag as an argument or requested help
if [ $# -eq 1 ]; then
  if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    help_message
    exit 0
  else
    TAG=$1
  fi
else
  TAG=$DEFAULT_TAG
fi

# Run the Docker container
docker run -it --rm \
  -p 8888:7860 \
  --runtime=nvidia --gpus all \
  -v "$(pwd)"/outputs:/content/stable-diffusion-webui/outputs \
  -v "$(pwd)"/data:/content/stable-diffusion-webui/data \
  -v "$(pwd)"/textual_inversion:/content/stable-diffusion-webui/textual_inversion \
  aghorbani/stable-diffusion-webui:"$TAG"

#-v "$(pwd)"/styles.csv:/content/stable-diffusion-webui/styles.csv \