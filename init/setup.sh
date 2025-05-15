#!/bin/sh

# Create buckets for each project
mc mb local/kis-chatbot
mc mb local/geo-elab-chatbot

# Add subfolders (using dummy file, as S3 doesn't support empty folders)
echo "{}" | mc pipe local/kis-chatbot/photos/
echo "{}" | mc pipe local/geo-elab-chatbot/photos/

echo "Buckets initialized."
