#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "🔍 Fetching the latest Cloud Build..."

# Get the ID and Status of the most recent build
# We use --format="value(id,status)" to get raw text output
read -r BUILD_ID STATUS <<< $(gcloud builds list --limit=1 --format="value(id,status)")

if [ -z "$BUILD_ID" ]; then
  echo "❌ No builds found for this project."
  exit 1
fi

echo "🆔 Build ID: $BUILD_ID"
echo "📊 Status:   $STATUS"

# Check if the build is currently active
if [[ "$STATUS" == "WORKING" ]] || [[ "$STATUS" == "QUEUED" ]]; then
  echo "----------------------------------------"
  echo "▶️  Build is active. Streaming logs..."
  echo "----------------------------------------"
  gcloud builds log "$BUILD_ID" --stream
else
  echo "----------------------------------------"
  echo "ℹ️  Build finished. Run 'gcloud builds log $BUILD_ID' to see logs."
  echo "----------------------------------------"
fi