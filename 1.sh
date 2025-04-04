#!/bin/bash

# File containing the list of URLs
URL_FILE="urls.txt"

# Directory to save downloaded audio
DOWNLOAD_DIR="audio"

# Check if the URL file exists
if [ ! -f "$URL_FILE" ]; then
  echo "❌ Error: '$URL_FILE' not found."
  exit 1
fi

# Create the audio directory if it doesn't exist
mkdir -p "$DOWNLOAD_DIR"

# Loop through each URL in the file and download best audio
while IFS= read -r url || [ -n "$url" ]; do
  if [ -n "$url" ]; then
    echo "🎧 Downloading audio from: $url"
    yt-dlp \
      -f bestaudio \
      -x \
      --audio-format mp3 \
      --audio-quality 0 \
      -o "$DOWNLOAD_DIR/%(title)s.%(ext)s" \
      "$url"
  fi
done < "$URL_FILE"

echo "✅ All downloads completed. Files are saved in '$DOWNLOAD_DIR/'."

