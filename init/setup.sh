mc alias set local http://minio:9000 ${MINIO_ROOT_USER} ${MINIO_ROOT_PASSWORD}
echo "MinIO is running and accessible!"
mc version
cat > /tmp/env.conf << EOF
export MINIO_BROWSER_REDIRECT_URL=
export MINIO_BROWSER=on
export MINIO_DOMAIN=
export MINIO_CORS_ALLOW_ORIGIN="*"
EOF
mc admin config import local /tmp/env.conf
echo "MinIO setup complete. You can create buckets and configure CORS for them as needed."