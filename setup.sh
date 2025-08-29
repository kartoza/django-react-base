#!/usr/bin/env bash

# --------------------------------------------------
# Kartoza django Setup Script
# --------------------------------------------------

echo ""
echo "======================================"
echo "               🌍 Setup               "
echo "======================================"
echo ""

# --------------------------------------------------
# Copy .env
# --------------------------------------------------
if [ ! -f deployment/.env ]; then
  cp deployment/.template.env deployment/.env
  echo "✅ deployment/.env file created successfully."
else
  echo "✅ deployment/.env file already exists. Skipping."
fi

echo ""

# --------------------------------------------------
# Copy docker-compose.override.yml
# --------------------------------------------------
if [ ! -f deployment/docker-compose.override.yml ]; then
  echo "🔧 Setting up Docker Compose override..."
  echo "------------------------------------------"
  echo "Copying deployment/docker-compose.override.template.yml → deployment/docker-compose.override.yml"
  cp deployment/docker-compose.override.template.yml deployment/docker-compose.override.yml
  echo "✅ deployment/docker-compose.override.yml file created successfully."
else
  echo "✅ deployment/docker-compose.override.yml already exists. Skipping."
fi

echo ""
echo "🚀 Setup complete!"
echo ""
echo "Now you can launch vscode by running:"
echo ""
echo "./vscode.sh"
echo ""
