#!/bin/sh

# Create buckets for each project
mc mb local/kis-chatbot
mc mb local/geo-elab-chatbot

# Add subfolders (using dummy file, as S3 doesn't support empty folders)
echo "{}" | mc pipe local/kis-chatbot/photos/
echo "{}" | mc pipe local/geo-elab-chatbot/photos/

# Create an images folder for kis-chatbot
echo "{}" | mc pipe local/kis-chatbot/images/

# Set buckets to public
mc anonymous set public local/kis-chatbot
mc anonymous set public local/geo-elab-chatbot

# Configure CORS for the buckets
mc admin config set local cors:kis-chatbot <<EOF
{
  "corsRules": [
    {
      "allowedHeaders": ["*"],
      "allowedMethods": ["GET", "HEAD"],
      "allowedOrigins": ["*"],
      "exposeHeaders": ["Etag"],
      "maxAgeSeconds": 3600
    }
  ]
}
EOF

# Restart MinIO to apply CORS settings
mc admin service restart local

echo "Buckets initialized with public access policies and CORS settings."